require_relative 'helper_test'
require_relative '../lib/invoice_item'
require 'bigdecimal'
require 'time'

# Tests the info passes correctly in InvoiceItems
class InvoiceItemTest < Minitest::Test
  def setup
    @info = { id:           88,
              item_id:      66,
              invoice_id:   46,
              quantity:     10,
              unit_price:   BigDecimal.new(10.994, 4),
              created_at:   Time.now.inspect,
              updated_at:   Time.now.inspect }
    @invoice_item = InvoiceItem.new(@info)
  end

  def test_if_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_id_attributes
    assert_equal @info[:id], @invoice_item.id
    assert_equal @info[:item_id], @invoice_item.item_id
    assert_equal @info[:invoice_id], @invoice_item.invoice_id
  end

  def test_quantituy_and_price_attributes
    assert_equal @info[:quantity], @invoice_item.quantity
    assert_equal 0.1099e0, @invoice_item.unit_price
  end

  def test_time_attributes
    assert_instance_of Time, @invoice_item.created_at
    assert_instance_of Time, @invoice_item.updated_at
  end

  def test_if_it_can_return_unit_price_in_dollars
    assert_equal '$0.11', @invoice_item.unit_price_to_dollars
  end
end
