require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant_repository'

# Testing merchant repository
class MerchantRepoTest < MiniTest::Test
  def setup
    @merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repo
  end

  def test_it_has_merchants
    assert_equal 20, @merchant_repo.all.count
    assert_instance_of Array, @merchant_repo.all
    assert_equal 'Shopin1901', @merchant_repo.all.first.name
  end

  def test_it_can_find_by_id
    result = @merchant_repo.find_by_id(12334105)

    assert_instance_of Merchant, result
    assert_equal 'Shopin1901', result.name
    assert_equal 12334105, result.id
  end

  def test_it_can_find_by_name
    result = @merchant_repo.find_by_name('MiniatureBikez')

    assert_instance_of Merchant, result
    assert_equal 'MiniatureBikez', result.name
    assert_equal 123_341_13, result.id
  end

  def test_find_by_name_returns_nil
    result = @merchant_repo.find_by_name('MountainCruisers')

    assert_nil result
  end

  def test_it_can_find_all_by_name
    result = @merchant_repo.find_all_by_name('Ray')

    assert_instance_of Array, result
    assert_equal 1, result.count
  end

  def test_find_all_returns_empty_for_no_match
    result = @merchant_repo.find_all_by_name('Goblin')

    assert_instance_of Array, result
    assert_equal [], result
  end
end
