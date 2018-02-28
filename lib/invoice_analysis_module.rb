require 'bigdecimal'

# This module holds the code to analyze invoices for the sales_analyst
module InvoiceAnalysis
  def average_invoices_per_merchant
    num = invoices.size
    div = merchants.size
    Calculator.average(num, div).round(2)
  end

  def total_invoices(merchant_id)
    @engine.invoices.find_all_by_merchant_id(merchant_id).size
  end

  def total_invoices_per_merchant
    merchants.map do |merchant|
      total_invoices(merchant.id)
    end
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    array = merchants.map { |merchant| total_invoices(merchant.id) }
    Calculator.standard_deviation(array, average)
  end

  def invoice_two_stdev_up
    zscore = average_invoices_per_merchant_standard_deviation
    average_invoices_per_merchant + (zscore * 2)
  end

  def invoice_two_stdev_down
    zscore = average_invoices_per_merchant_standard_deviation
    average_invoices_per_merchant - (zscore * 2)
  end

  def zip_merchants_by_invoice
    total_invoices_per_merchant.zip(merchants)
  end

  def find_upper_merchants
    zscore = invoice_two_stdev_up
    zip_merchants_by_invoice.find_all { |invoice| invoice[0] > zscore }
  end

  def top_merchants_by_invoice_count
    top_merchants = find_upper_merchants
    top_merchants.map { |invoice| invoice[1] }
  end

  def find_bottom_merchants
    zscore = invoice_two_stdev_down
    zip_merchants_by_invoice.find_all { |invoice| invoice[0] < zscore }
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = find_bottom_merchants
    bottom_merchants.map { |invoice| invoice[1] }
  end

  def invoices_by_day
    invoices.map { |invoice| invoice.created_at.strftime('%A') }
  end

  def invoice_count_by_day
    @days.map { |day| invoices_by_day.count(day) }
  end

  def average_invoices_per_day
    count = 7
    total = invoice_count_by_day.reduce(:+)
    Calculator.average(total, count).round(2)
  end

  def invoice_per_day_stdev
    array = invoice_count_by_day
    average = average_invoices_per_day
    Calculator.standard_deviation(array, average)
  end

  def attach_invoice_count_to_day
    invoice_count_by_day.zip(@days)
  end

  def find_all_invoices_for_top_days
    array = attach_invoice_count_to_day
    average = average_invoices_per_day
    stdev = invoice_per_day_stdev
    array.find_all { |invoice| invoice[0] > (average + stdev) }
  end

  def top_days_by_invoice_count
    find_all_invoices_for_top_days.map { |day| day[1] }
  end

  def invoice_status(status)
    num = find_all_status(status)
    div = invoices.count
    ((num / div) * 100).round 2
  end

  def find_all_status(status)
    @engine.invoices.find_all_by_status(status).count.to_f
  end

  def customers_with_unpaid_invoices
    unpaid = []
    invoices = customers.map(&:invoices)
    invoices.flatten.each do |invoice|
      unpaid << invoice.customer unless invoice.is_paid_in_full?
    end
    unpaid.uniq
  end
end
