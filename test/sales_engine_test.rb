require_relative 'helper_test'

require_relative '../lib/sales_engine'

# Testing merchant class
class SalesEngineTest < MiniTest::Test
  def setup
    @data = { items:         './data/items.csv',
              merchants:     './data/merchants.csv',
              invoices:      './data/invoices.csv',
              invoice_items: './data/invoice_items.csv',
              transactions:  './data/transactions.csv',
              customers:     './data/customers.csv' }
    @se = SalesEngine.from_csv(@data)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_find_items_by_merchant_id
    items = @se.find_items_by_merchant_id(123_359_71)
    assert_equal 1, items.length
  end

  def test_find_merchant_by_id
    result = @se.find_merchant(123_359_71)
    assert_instance_of Merchant, result
  end

  def test_find_invoices_by_merchant_id
    result = @se.find_invoices_by_merchant_id(123_359_71)
    assert_instance_of Array, result
    assert_instance_of Invoice, result.first
  end
end
