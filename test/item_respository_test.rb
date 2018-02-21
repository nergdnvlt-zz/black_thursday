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

  # def test_find_by_id_returns_nil_if_item_does_not_exist
  #   assert_nil @item_repo.find_by_id(263395617)
  # end

  def test_find_by_id_returns_item_instance_with_matching_id
   item = @item_repo.find_by_id(263395617)

   assert_equal 263395617, item.find_by_id(263395617)
   # assert_instance_of Item, item
 end
end

  # def test_find_by_id
  #   result = @item_repo.find_by_id(263395617)
  # end
