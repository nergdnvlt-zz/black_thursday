require_relative 'helper_test'

require_relative '../lib/transaction'

# Tests the transaction class
class TransactionTest < MiniTest::Test
  def setup
    @data = { id: 6,
              invoice_id: 8,
              credit_card_number: '4242424242424242',
              credit_card_expiration_date: '0220',
              result: 'success',
              created_at: Time.now.inspect,
              updated_at: Time.now.inspect }
    @transaction = Transaction.new(@data)
  end

  def test_it_has_an_id
    assert_equal 6, @transaction.id
  end

  def test_it_has_invoice_id
    assert_equal 8, @transaction.invoice_id
  end

  def test_it_has_credit_card_number
    assert_equal 424_242_424_242_424_2, @transaction.credit_card_number
  end

  def test_it_has_credit_card_expiration_date
    assert_equal '0220', @transaction.credit_card_expiration_date
  end

  def test_it_has_result
    assert_equal 'success', @transaction.result
  end

  def test_it_has_created_at
    result = @transaction.created_at.inspect
    assert_equal Time.now.inspect, result
  end

  def test_it_has_updated_at
    result = @transaction.updated_at.inspect
    assert_equal Time.now.inspect, result
  end
end
