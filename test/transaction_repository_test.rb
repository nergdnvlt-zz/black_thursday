require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require_relative '../lib/transaction_repository'

# Tests the Transaction Repository
class TransactionRepositoryTest < MiniTest::Test
  def setup
    @transaction_repo = TransactionRepository.new('./data/transactions.csv')
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction_repo
  end

  def test_it_can_find_by_id
    result = @transaction_repo.find_by_id(1)
    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_invoice_id
    result = @transaction_repo.find_all_by_invoice_id(2179)
    assert_instance_of Array, result
    assert_equal 2, result.count
  end

  def test_it_can_find_all_by_find_all_by_credit_card_number
    result = @transaction_repo.find_all_by_credit_card_number(4068631943231473)
    assert_instance_of Array, result
    assert_equal 1, result.count
  end

  def test_it_can_find_all_by_result
    result = @transaction_repo.find_all_by_result("success")
    assert_instance_of Array, result
    assert_equal 4158, result.count
  end

  def test_inspect_method
    assert_instance_of String, @transaction_repo.inspect
  end
end
