require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
      items:     './test/fixtures/items.csv',
      merchants: './test/fixtures/merchants.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_finds_all_the_merchants
    merchants = @sa.merchants
    assert_equal 9, merchants.count
  end

  def test_it_finds_all_the_items
   items = @sa.items
   assert_equal 34, items.count
 end

 def test_it_finds_average_items_per_merchant
   assert_equal 3.78, @sa.average_items_per_merchant
 end

 def test_it_finds_the_average_items_per_merchant_stdev
    assert_equal 4.01, @sa.average_items_per_merchant_standard_deviation
  end
end
