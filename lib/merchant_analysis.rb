require 'bigdecimal'

# Calculation methods for merchants
module MerchantAnalysis
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
    inventory = @engine.merchants.find_by_id(merchant_id).items
    prices    = inventory.map(&:unit_price)
    (prices.reduce(:+) / inventory.size).round(2)
  end

  def average_average_price_per_merchant
    total = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (total / merchants.size).round(2)
  end
end
