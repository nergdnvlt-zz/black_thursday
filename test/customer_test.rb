require_relative 'helper_test'
require_relative '../lib/customer'

# Test that attributes of customers are accessed correctly
class CustomerTest < MiniTest::Test
  def setup
    @data = { id: 8,
              first_name: 'Hela',
              last_name: 'Odinson',
              created_at: Time.now.inspect,
              updated_at: Time.now.inspect }
    @cust = Customer.new(@data)
  end

  def test_if_it_exists
    assert_instance_of Customer, @cust
  end

  def test_id_attributes
    assert_equal 8, @cust.id
    assert_equal 'Hela', @cust.first_name
    assert_equal 'Odinson', @cust.last_name
  end

  def test_time_attributes
    assert_equal Time.now.inspect, @cust.created_at.inspect
  end
end
