require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

require_relative '../lib/sales_analyst'

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
   assert_equal 1, items.count
 end
end
