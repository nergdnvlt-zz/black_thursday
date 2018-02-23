require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

# Tests the item class
class InvoiceTest < MiniTest::Test
  def setup
    @time = Time.now
    @invoice = Invoice.new({
                       id: 2,
                       customer_id: 1,
                       status: "shipped",
                       created_at: Time.now.inspect,
                       updated_at: Time.now.inspect,
                     })
  end

  def test_it_has_an_id
    assert_equal 2, @invoice.id
  end

  def test_it_has_a_customer_id
    assert_equal 1, @invoice.customer_id
  end

  def test_it_has_a_status
    assert_equal "shipped", @invoice.status
  end
end
