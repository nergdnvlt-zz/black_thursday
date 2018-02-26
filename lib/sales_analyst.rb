require 'bigdecimal'

require_relative 'calculator'

# This class analyzes all the data from the sales engine.
class SalesAnalyst
  include Calculator

  attr_reader :days

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def invoices
    @sales_engine.invoices.all
  end

  def average_items_per_merchant
    num = items.count.to_f
    div = merchants.count
    Calculator.average(num, div).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    array = merchants.map do |merchant|
      merchant.items.count
    end
    Calculator.standard_deviation(array, average)
  end

  def one_stdev_above_average
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    high_item_count = one_stdev_above_average
    merchants.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    inventory = @sales_engine.merchants.find_by_id(merchant_id).items
    prices    = inventory.map(&:unit_price)
    (prices.reduce(:+) / inventory.size).round(2)
  end

  def average_average_price_per_merchant
    total = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (total / merchants.size).round(2)
  end

  def average_item_price
    num = items.map { |item| item.unit_price.to_i }.reduce(:+)
    div = items.size
    Calculator.average(num, div).round(2)
  end

  def average_items_price_standard_deviation
    average = average_item_price
    item_array = items.map(&:unit_price)
    Calculator.standard_deviation(item_array, average)
  end

  def two_stdev_above_average_for_golden
    average_item_price + (average_items_price_standard_deviation * 2).round(2)
  end

  def golden_items
    high_item_count = two_stdev_above_average_for_golden
    items.find_all do |item|
      item.unit_price > high_item_count
    end
  end

  def average_invoices_per_merchant
    num = invoices.size
    div = merchants.size
    Calculator.average(num, div).round(2)
  end

  def total_invoices(merchant_id)
    @sales_engine.invoices.find_all_by_merchant_id(merchant_id).size
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
    @sales_engine.invoices.find_all_by_status(status).count.to_f
  end

  def top_buyers(num = 20)
    hash = {}
    @sales_engine.customers.all.each do |customer|
      buyers_hash(customer, hash)
    end
    top_customers = hash.keys.max(num)
    top_customers.map { |key| hash[key] }
  end

  def buyers_hash(customer, hash)
    invoices = find_invoices(customer.id)
    paid_invoices = invoices.find_all(&:is_paid_in_full?)
    invoice_costs = paid_invoices.map(&:total)
    hash[invoice_costs.reduce(:+).to_f] = customer
  end

  def find_invoices(customer_id)
    @sales_engine.invoices.find_all_by_customer_id(customer_id)
  end
end
