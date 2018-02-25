require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require_relative '../lib/invoice_item_repository'

# Tests the Invoice Item Repository
class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    @invoice_item_repo = InvoiceItemRepository.new('./data/invoice_items.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end

  def test_it_has_id
    assert_equal 21830, @invoice_item_repo.all.count
    assert_instance_of Array, @invoice_item_repo.all
  end

  def test_it_can_find_by_id
    result = @invoice_item_repo.find_by_id(5)
    assert_equal 5, result.id
  end

  def test_it_can_find_all_by_item_id
    result = @invoice_item_repo.find_all_by_item_id(263519844)
    assert_instance_of Array, result
    # assert_equal 164, result.count
  end

  def test_it_can_find_all_by_invoice_id
    result = @invoice_item_repo.find_all_by_invoice_id(1)
    assert_instance_of Array, result
    # assert_equal 164, result.count
  end
end
