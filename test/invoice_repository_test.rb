require_relative 'helper_test'

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

  def test_it_can_find_by_id_returns_nil
    result = @invoice_repo.find_by_id(500_0)

    assert_nil result
  end

  def test_it_finds_by_customer_id_returns_empty_array
    result = @invoice_repo.find_all_by_customer_id(997)

    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_it_finds_all_by_customer_id
    result = @invoice_repo.find_all_by_customer_id(2)

    assert_instance_of Array, result
    assert_equal 4, result.count
  end

  def test_it_finds_all_by_merchant_id_returns_empty_array
    result = @invoice_repo.find_all_by_merchant_id(12)

    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_it_finds_all_by_merchant_id
    result = @invoice_repo.find_all_by_merchant_id(123_353_19)

    assert_instance_of Array, result
    assert_equal 13, result.count
  end

  def test_it_finds_all_by_status_returns_empty_array
    result = @invoice_repo.find_all_by_status(:sold)

    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_it_finds_all_by_status
    result = @invoice_repo.find_all_by_status(:shipped)

    assert_instance_of Array, result
    assert_equal 2839, result.count
  end

  def test_it_can_find_an_invoice_by_id
    result = @invoice_repo.find_by_id(1888)

    assert_instance_of Invoice, result
    assert_equal 1888, result.id
    assert_equal 375, result.customer_id
    assert_equal 123_360_45, result.merchant_id
    assert_equal :shipped, result.status
  end

  def test_inspect_method
    assert_instance_of String, @invoice_repo.inspect
  end
end
