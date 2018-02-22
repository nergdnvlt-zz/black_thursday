require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

# Testing merchant class
class MerchantTest < MiniTest::Test
  def tests_it_exists
    merchant = Merchant.new({id: '5', name: 'Turing School'})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new({id: '5', name: 'Turing School'})

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end

  def test_it_has_different_attributes
    merchant = Merchant.new({id: '8', name: 'Hogwarts'})

    assert_equal 8, merchant.id
    assert_equal 'Hogwarts', merchant.name
  end

  def test_if_it_returns_all_items_for_a_merchant
    data = { items: './test/fixtures/items.csv',
             merchants: './test/fixtures/merchants.csv' }
    sales_engine = SalesEngine.new(data)
    id = 123_341_85
    merchant = sales_engine.merchants.find_by_id(id)

    assert merchant.items.class == Array
    assert merchant.items.first.class == Item
    assert_equal 3, merchant.items.length
  end
end
