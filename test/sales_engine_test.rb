require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'

# Testing merchant class
class SalesEngineTest < MiniTest::Test
  def setup
    @data = {
              items: './data/items.csv',
              merchants: './data/merchants.csv'
            }
    @sales_engine = SalesEngine.from_csv(@data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_for_from_csv_method
    assert_equal @data[:items], SalesEngine.from_csv(@data).item_csv_path
    assert_equal @data[:merchants], SalesEngine.from_csv(@data).merchant_csv_path
  end
end
