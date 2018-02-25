require_relative 'helper_test'

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
    assert_equal 218_30, @invoice_item_repo.all.count
    assert_instance_of Array, @invoice_item_repo.all
  end

  def test_it_can_find_by_id
    result = @invoice_item_repo.find_by_id(5)
    assert_equal 5, result.id
  end

  def test_it_can_find_all_by_item_id
    result = @invoice_item_repo.find_all_by_item_id(263_519_844)
    assert_instance_of Array, result
    assert_equal 164, result.count
  end

  def test_it_returns_empty_array_for_find_all_by_invoice_id
    result = @invoice_item_repo.find_all_by_invoice_id(5000)
    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_inspect_method
    assert_instance_of String, @invoice_item_repo.inspect
  end
end
