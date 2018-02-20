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

    assert_equal 9, merchant_repo.all.count
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

  def test_it_can_find_by_name
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')
    result = merchant_repo.find_by_name('MiniatureBikez')

    assert_instance_of Merchant, result
    assert_equal 'MiniatureBikez', result.name
    assert_equal 3, result.id
  end

  def test_it_can_find_all_by_name
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')
    result = merchant_repo.find_all_by_name('Ray')

    assert_instance_of Array, result
    assert_equal ['GoldenRayPress', 'SunRaySites'], result
  end
end
