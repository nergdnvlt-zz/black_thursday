require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant'

# Testing merchant class
class MerchantTest < MiniTest::Test
  def tests_it_exists
    merchant = Merchant.new({id: '5', name: 'Turing School'})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new({id: '5', name: 'Turing School'})

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end

  def test_it_has_different_attributes
    merchant = Merchant.new({id: '8', name: 'Hogwarts'})

    assert_equal 8, merchant.id
    assert_equal 'Hogwarts', merchant.name
  end
end
