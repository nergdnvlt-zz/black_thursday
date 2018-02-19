require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant_repository'

# Testing merchant repository
class MerchantRepoTest < MiniTest::Test
  def test_it_exists
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_it_has_merchants
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_equal 8, merchant_repo.all.count
    assert_instance_of Array, merchant_repo.all
    assert_equal 'Shopin1901', merchant_repo.all.first.name
  end

  def test_it_can_find_by_id
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')
    result = merchant_repo.find_by_id(1)

    assert_instance_of Merchant, result
    assert_equal 'Shopin1901', result.name
    assert_equal 1, result.id
  end
end
