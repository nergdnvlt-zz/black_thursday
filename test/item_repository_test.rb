require_relative 'helper_test'

require_relative '../lib/item_repository'

# Tests the Item Repository
class ItemRepositoryTest < MiniTest::Test
  def setup
    @item_repo = ItemRepository.new('./data/items.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_find_by_id_returns_nil_if_item_does_not_exist
    assert_nil @item_repo.find_by_id(10)
  end

  def test_find_by_id_returns_item_instance_with_matching_id
    item = @item_repo.find_by_id(263_395_617)

    assert_equal 263_395_617, item.id
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
    assert_equal 8, result.count
  end

  def test_find_all_by_price_returns_empty_array_for_nil
    result = @item_repo.find_all_by_price(88.00)
    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_it_finds_by_range
    result = @item_repo.find_all_by_price_in_range(12.00..14.00)
    assert_instance_of Array, result
    assert_equal 70, result.count
  end

  def test_it_finds_by_range_returns_empty
    result = @item_repo.find_all_by_price_in_range(20000..20001)
    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_it_finds_by_merchant_id
    result = @item_repo.find_all_by_merchant_id(123_341_85)
    assert_instance_of Array, result
    assert_equal 6, result.count
  end

  def test_it_finds_by_merchant_id_returns_empty_array
    result = @item_repo.find_all_by_merchant_id(88)
    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_inspect_method
    assert_instance_of String, @item_repo.inspect
  end
end
