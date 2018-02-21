require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/item_repository'

class ItemRepositoryTest < MiniTest::Test
  def setup
    @item_repo = ItemRepository.new('./test/fixtures/items.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_find_by_id_returns_nil_if_item_does_not_exist
    assert_nil @item_repo.find_by_id(10)
  end

  def test_find_by_id_returns_item_instance_with_matching_id
    item = @item_repo.find_by_id(263395617)

    assert_equal 263395617, item.id
    assert_instance_of Item, item
  end

  def test_find_by_name
    result = @item_repo.find_by_name('Glitter scrabble frames')
    assert_equal 'Glitter scrabble frames', result.name
  end

  def test_find_all_with_descriptions
    result = @item_repo.find_all_with_description('scrabble frames')
    assert_instance_of Array, result
    assert_equal 1, result.count
  end

  def test_find_all_with_desc_returns_empty_for_no_match
    result = @item_repo.find_all_with_description('Goblin')

    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_find_all_by_price
    result = @item_repo.find_all_by_price(13.00)
    assert_instance_of Array, result
    assert_equal 1, result.count
  end

  def test_find_all_by_price_returns_empty_array_for_nil
    result = @item_repo.find_all_by_price(88.00)
    assert_instance_of Array, result
    assert_equal [], result
  end
end
