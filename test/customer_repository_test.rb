require 'CSV'
require_relative 'helper_test'
require_relative '../lib/customer_repository'

# Test that attributes of customers are accessed correctly
class CustomerRepositoryTest < MiniTest::Test
  def setup
    @cust_repo = CustomerRepository.new('./data/customers.csv')
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cust_repo
  end

  def test_if_customers_repository_has_customers
    assert_instance_of Array, @cust_repo.all
    assert_instance_of Customer, @cust_repo.all.first
  end

  def test_it_can_find_customer_by_id
    result = @cust_repo.find_by_id(88)
    assert_instance_of Customer, result
    assert_equal 'Jacynthe', result.first_name
    assert_equal 'Beatty', result.last_name
  end

  def test_find_all_by_first_name_returns_empty_for_unfound
    result = @cust_repo.find_all_by_first_name('Valkyrie')
    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_finds_a_customer_by_first_name
    result = @cust_repo.find_all_by_first_name('Vladimir')
    assert_instance_of Array, result
    assert_equal 2, result.size
  end

  def test_finds_a_customer_by_first_name_fragment
    result = @cust_repo.find_all_by_first_name('Vl')
    assert_instance_of Array, result
    assert_equal 2, result.size
  end

  def test_finds_a_customer_by_first_name_case_insensitive
    result = @cust_repo.find_all_by_first_name('vLaDImIR')
    assert_instance_of Array, result
    assert_equal 2, result.size
  end


  def test_find_all_by_last_name_returns_empty_for_unfound
    result = @cust_repo.find_all_by_last_name('Erikkson')
    assert_instance_of Array, result
    assert_equal [], result
  end

  def test_finds_a_customer_by_last_name
    result = @cust_repo.find_all_by_last_name('Kirlin')
    assert_instance_of Array, result
    assert_equal 3, result.size
  end

  def test_finds_a_customer_by_last_name_frag
    result = @cust_repo.find_all_by_last_name('rl')
    assert_instance_of Array, result
    assert_equal 6, result.size
  end

  def test_finds_a_customer_by_last_name_case_insensitive
    result = @cust_repo.find_all_by_last_name('kIRlIn')
    assert_instance_of Array, result
    assert_equal 3, result.size
  end

  def test_inspect_method
    assert_instance_of String, @cust_repo.inspect
  end
end
