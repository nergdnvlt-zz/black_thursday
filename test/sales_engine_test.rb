require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/sales_engine'

# Testing merchant class
class SalesEngineTest < MiniTest::Test
  def test_it_exists
    sales_engine = SalesEngine.from_csv({
                                          items: './data/items.csv',
                                          merchants: './data/merchants.csv'
                                        })
    assert_instance_of SalesEngine, sales_engine
  end
end
