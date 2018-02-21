# require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < MiniTest::Test

  def setup
    @time = Time.now
    @item = Item.new({
      id: 263395617,
      name: "Glitter scrabble frames",
      description: "Glitter scrabble frames Any colour glitter Any wording Available colour scrabble tiles Pink Blue Black Wooden",
      unit_price: 1300,
      created_at: Time.now.inspect,
      updated_at: Time.now.inspect,
      merchant_id: 12334185
    }, mock('ItemRepository'))
  end

  def test_it_has_an_id
    assert_equal 263395617, @item.id
  end

  def test_it_has_an_name
    expect = "Glitter scrabble frames"

    assert_equal , @item.name
  end

  def test_it_has_description
    expect = "Glitter scrabble frames Any colour glitter Any wording Available colour scrabble tiles Pink Blue Black Wooden"

    assert_equal expect, @item.description
  end

  def test_it_has_unit_price
    assert_equal 0.1099e2, @item.unit_price
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
    assert_equal 263395617, @item.merchant_id
  end

  def test_unit_price_in_dollars
    assert_equal 1.00, @item.unit_price_in_dollars
  end

  def test_it_calls_item_repository_to_return_merchant
    ir = mock("item_repository")
    item = Item.new({
      id: 263395617,
      name: "Glitter scrabble frames",
      description: "Glitter scrabble frames Any colour glitter Any wording Available colour scrabble tiles Pink Blue Black Wooden",
      unit_price: 1300,
      created_at: Time.now.inspect,
      updated_at: Time.now.inspect,
      merchant_id: 12334185
      }, ir)
  end
end
