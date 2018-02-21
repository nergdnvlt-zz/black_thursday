require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'

# Testing merchant class
class SalesEngineTest < MiniTest::Test
  def setup
    @data = { items: './data/items.csv',
              merchants: './data/merchants.csv' }
    @sales_engine = SalesEngine.from_csv(@data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_for_from_csv_method
    assert_equal @data[:items], SalesEngine.from_csv(@data).item_csv
    assert_equal @data[:merchants], SalesEngine.from_csv(@data).merchant_csv
  end

  def test_find_items_by_merchant_id
    items = @sales_engine.find_items_by_merchant_id(12335971)
    assert_equal 1, items.length
  end
end
