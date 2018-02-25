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

  def invoice_two_stdev
    zscore2 = (average_invoices_per_merchant_standard_deviation * 2)
    average_invoices_per_merchant + zscore2
  end

  def zip_merchants_by_invoice
    total_invoices_per_merchant.zip(merchants)
  end

  def find_upper_merchants
    zscore = invoice_two_stdev
    zip_merchants_by_invoice.find_all { |invoice| invoice[0] > zscore }
  end

  def top_merchants_by_invoice_count
    top_merchants = find_upper_merchants
    top_merchants.map { |invoice| invoice[1] }
  end

  def find_bottom_merchants
    zscore = invoice_two_stdev
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

  # def invoices_per_day_standard_deviation
  #   dif = @days_of_week_invoice_count.map do |num|
  #     (num - @avg_invoices_per_day)**2
  #   end
  #   added = dif.inject { |sum, num| sum + num }.to_f
  #   Math.sqrt(added / (@days_of_week_invoice_count.count - 1)).round(2)
  # end
end
