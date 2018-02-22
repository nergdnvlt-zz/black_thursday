require 'bigdecimal'

# This class analyzes all the data from the sales engine.
class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def average_items_per_merchant
    (items.count.to_f / merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_item_count = average_items_per_merchant
    Math.sqrt(
      merchants.reduce(0) do |sum, merchant|
        sum + (merchant.items.count - average_item_count)**2
      end / (merchants.count - 1)
    ).round(2)
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
    total = items.map { |item| item.unit_price.to_i }.reduce(:+)
    total / items.size
  end

  def deviation_of_each_item
    items.reduce(0) do |sum|
      sum + items.average_item_price
    end
  end

  def golden_items
    high_item_count = two_stdev_above_average_for_golden
    items.find_all do |item|
      item.unit_price > high_item_count
    end
  end

  def average_items_price_standard_deviation
    Math.sqrt(
      items.reduce(0) do |sum, item|
        sum + (item.unit_price - average_item_price)**2
      end / (items.count - 1)
    ).round(2)
  end

  def two_stdev_above_average_for_golden
    average_item_price + (average_items_price_standard_deviation * 2)
  end
end
