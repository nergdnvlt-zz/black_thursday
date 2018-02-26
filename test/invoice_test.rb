require_relative 'helper_test'

require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

# Tests the item class
class InvoiceTest < MiniTest::Test
  def setup
    @time = Time.now
    @data = { id: 2,
              customer_id: 1,
              merchant_id: 123_347_53,
              status: 'shipped',
              created_at: Time.now.inspect,
              updated_at: Time.now.inspect }
    @csvinfo = { items:         './data/items.csv',
                 merchants:     './data/merchants.csv',
                 invoices:      './data/invoices.csv',
                 invoice_items: './data/invoice_items.csv',
                 transactions:  './data/transactions.csv',
                 customers:     './data/customers.csv' }
    @invoice = Invoice.new(@data)
  end

  def test_it_has_an_id
    assert_equal 2, @invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 1, @invoice.customer_id
  end

  def test_it_has_merchant_id
    assert_equal 123_347_53, @invoice.merchant_id
  end

  def test_it_has_a_status
    assert_equal :shipped, @invoice.status
  end

  def test_it_has_created_at
    result = @invoice.created_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_it_has_updated_at
    result = @invoice.updated_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_if_it_returns_the_merchant_for_an_invoice
    sales_engine = SalesEngine.new(@csvinfo)
    id = 641
    invoice = sales_engine.invoices.find_by_id(id)

    assert invoice.id == id
    assert invoice.merchant.name == 'jejum'
    assert invoice.merchant.class == Merchant
  end

  def test_if_it_returns_all_items_for_an_invoice
    sales_engine = SalesEngine.new(@csvinfo)
    id = 106
    invoice = sales_engine.invoices.find_by_id(id)

    assert invoice.id == id
    assert_instance_of Item, invoice.items.first
    assert invoice.items.first.class == Item
  end

  def test_if_it_returns_all_transactions_for_an_invoice
   sales_engine = SalesEngine.new(@csvinfo)
   id = 106
   invoice = sales_engine.invoices.find_by_id(id)

   assert invoice.id == id
   assert_instance_of Transaction, invoice.transactions.first
 end

  def test_if_it_returns_customer_based_on_customer_id
    sales_engine = SalesEngine.new(@csvinfo)
    id = 106
    invoice = sales_engine.invoices.find_by_id(id)

    assert invoice.id == id
    assert_instance_of Customer, invoice.customer
  end
end
