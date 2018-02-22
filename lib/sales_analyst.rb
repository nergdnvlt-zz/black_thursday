require 'bigdecimal'

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
end





# merchants_with_high_item_count
# average_item_price_for_merchant(12334159)
# average_average_price_per_merchant
# golden_items
