require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require_relative '../lib/invoice_repository'

# Tests the Invoice Repository
class InvoiceRepositoryTest < MiniTest::Test
  def setup
    @invoice_repo = InvoiceRepository.new('./data/invoices.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_has_invoices
    assert_equal 4985, @invoice_repo.all.count
    assert_instance_of Array, @invoice_repo.all
  end

  def test_it_can_find_by_id
    result = @invoice_repo.find_by_id(5)

    assert_instance_of Invoice, result
    assert_equal 5, result.id
  end

  def test_it_finds_by_merchant_id_returns_empty_array
    result = @invoice_repo.find_all_by_customer_id(12335938)
    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_it_finds_by_customer_id
    result = @invoice_repo.find_all_by_customer_id(12335938)
    assert_instance_of Array, result
    assert_equal 16, result.count
  end
end
