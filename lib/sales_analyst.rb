require 'bigdecimal'

require_relative 'calculator'
require_relative 'invoice_analysis'
require_relative 'merchant_analysis'
require_relative 'buyer_analysis'

# This class analyzes all the data from the sales engine.
class SalesAnalyst
  include Calculator
  include InvoiceAnalysis
  include MerchantAnalysis
  include BuyerAnalysis

  attr_reader :days

  def initialize(engine)
    @engine = engine
    @days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
  end

  def merchants
    @engine.merchants.all
  end

  def items
    @engine.items.all
  end

  def invoices
    @engine.invoices.all
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
end
