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
end





#
# average_items_per_merchant
# average_items_per_merchant_standard_deviation
# merchants_with_high_item_count
# average_item_price_for_merchant(12334159)
# average_average_price_per_merchant
# golden_items
