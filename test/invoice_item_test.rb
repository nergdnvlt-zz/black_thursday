require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

# Tests the item class
class InvoiceTest < MiniTest::Test
  def setup
    @invoice_item = InvoiceItem.new({ id: 6,
                                      item_id: 7,
                                      invoice_id: 8,
                                      quantity: 1,
                                      unit_price: 1099,
                                      created_at: Time.now.inspect,
                                      updated_at: Time.now.inspect })
  end

  def test_it_has_an_id
    assert_equal 6, @invoice_item.id
  end

  def test_it_has_item_id
    assert_equal 7, @invoice_item.item_id
  end

  def test_it_has_a_invoice_id
    assert_equal 8, @invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    assert_equal 1, @invoice_item.quantity
  end

  def test_it_has_created_at
    result = @invoice_item.created_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_it_has_updated_at
    result = @invoice_item.updated_at

    assert_equal Time.now.inspect, result.inspect
  end

  def test_it_has_unit_price
    assert_equal 0.1099e2,@invoice_item.unit_price
  end

  def test_it_has_unit_price_to_dollars
    assert_equal 10.99, @invoice_item.unit_price_in_dollars
  end
end
