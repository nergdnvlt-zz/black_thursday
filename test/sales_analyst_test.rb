require_relative 'helper_test'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# Test sales analyst class
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './data/items.csv',
      merchants: './data/merchants.csv',
      invoices:  './data/invoices.csv'
    )
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_finds_all_the_merchants
    merchants = @sa.merchants
    assert_equal 475, merchants.count
  end

  def test_it_finds_all_the_items
    items = @sa.items
    assert_equal 1367, items.count
  end

  def test_it_finds_average_items_per_merchant
    result = @sa.average_items_per_merchant
    assert_equal 2.88, result
  end

  def test_it_finds_the_average_items_per_merchant_stdev
    result = @sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, result
  end

  def test_one_stdev_above
    result = @sa.one_stdev_above_average
    expected = 6.14
    assert_equal expected, result
  end

  def test_merchants_with_the_highest_item_counts
     merchants = @sa.merchants_with_high_item_count
     assert_equal 52, merchants.count
  end

  def test_average_item_price_for_merchant
    result = @sa.average_item_price_for_merchant(123_341_85)
    assert result.is_a?(BigDecimal)
  end

  def test_average_average_item_price_for_merchant
    result = @sa.average_average_price_per_merchant
    assert result.is_a?(BigDecimal)
  end

  def test_average_item_price
    result = @sa.average_item_price
    expected = 250
    assert_equal expected, result
  end

  def test_average_items_price_standard_deviation
    result = @sa.average_items_price_standard_deviation
    expected = 2900.99
    assert_equal result, expected
  end

  def test_two_stdev_above
    result = @sa.two_stdev_above_average_for_golden
    expected = 6051.98
    assert_equal result, expected
  end

  def test_it_finds_golden_items
    golden_items = @sa.golden_items
    assert_equal 5, golden_items.count
  end
end
