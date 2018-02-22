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

  def one_stdev_above_average
   average_items_per_merchant + average_items_per_merchant_standard_deviation
 end

  def merchants_with_high_item_count
    high_item_count = one_stdev_above_average
    merchants.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end
# I am having trouble with this one, can you
# take a look at it? Thanks 
  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.find_merchant_by_merchant_id(merchant_id)
    return merchant.average_item_price
  end

end





# average_average_price_per_merchant
# golden_items
