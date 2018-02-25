# require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

# Tests the item class
class ItemTest < MiniTest::Test
  def setup
    @item = Item.new({
                       id: 263_395_617,
                       name: 'Glitter scrabble frames',
                       description: 'Glitter scrabble frames Any colour glitter Any wording Available colour scrabble tiles Pink Blue Black Wooden',
                       unit_price: 1300,
                       created_at: Time.now.inspect,
                       updated_at: Time.now.inspect,
                       merchant_id: 123_341_85
                     })
  end

  def test_it_has_an_id
    assert_equal 263_395_617, @item.id
  end

  def test_it_has_an_name
    expected = 'Glitter scrabble frames'

    assert_equal expected, @item.name
  end

  def test_it_has_description
    expect = 'Glitter scrabble frames Any colour glitter Any wording Available colour scrabble tiles Pink Blue Black Wooden'

    assert_equal expect, @item.description
  end

  def test_it_has_unit_price
    assert_equal 0.13e2, @item.unit_price
  end

  def test_it_has_created_at
    result = @item.created_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_it_has_updated_at
    result = @item.updated_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_it_has_merchant_id
    assert_equal 123_341_85, @item.merchant_id
  end

  def test_unit_price_in_dollars
    assert_equal 13.00, @item.unit_price_in_dollars
  end

  def test_if_it_returns_the_merchant_for_an_item
    data = { items: './test/fixtures/items.csv',
             merchants: './test/fixtures/merchants.csv',
             invoices: './data/invoices.csv' }
    sales_engine = SalesEngine.new(data)
    id = 263_395_721
    item = sales_engine.items.find_by_id(id)

    assert item.id == id
    assert item.merchant.name == 'JUSTEmonsters'
    assert item.merchant.class == Merchant
  end
end
