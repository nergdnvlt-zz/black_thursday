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

  def test_it_finds_all_of_everything
    merchants = @sa.merchants
    items = @sa.items
    invoices = @sa.invoices

    assert_equal 475, merchants.size
    assert_equal 1367, items.size
    assert_equal 4985, invoices.size
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
    expected = 250.93
    assert_equal expected, result
  end

  def test_average_items_price_standard_deviation
    result = @sa.average_items_price_standard_deviation
    expected = 2900.99
    assert_equal result, expected
  end

  def test_two_stdev_above
    result = @sa.two_stdev_above_average_for_golden
    expected = 6052.91
    assert_equal result, expected
  end

  def test_it_finds_golden_items
    golden_items = @sa.golden_items

    assert_instance_of Array, golden_items
    assert_equal 5, golden_items.count
  end

  def test_average_invoices_per_merchant
    result = @sa.average_invoices_per_merchant
    assert_equal 10.49, result
  end

  def test_total_invoices_per_merchant
    result = @sa.total_invoices(123_341_05)
    expected = 10
    assert_equal expected, result
  end

  def test_average_invoices_per_merchant_standard_deviation
    result = @sa.average_invoices_per_merchant_standard_deviation
    expected = 3.29
    assert_equal expected, result
  end

  def test_invoice_to_stdev
    result = @sa.invoice_two_stdev
    expected = 17.07
    assert_equal expected, result
  end

  def test_invoice_per_merchant
    result = @sa.total_invoices_per_merchant

    assert_instance_of Array, result
    assert_equal 475, result.size
  end

  def test_zip_merchants
    result = @sa.zip_merchants_by_invoice

    assert_instance_of Array, result
    assert_instance_of Array, result.first
  end

  def test_upper_merchants
    result = @sa.find_upper_merchants

    assert_instance_of Array, result
    assert_instance_of Array, result
  end

  def test_top_merchants_by_invoice_count
    result = @sa.top_merchants_by_invoice_count

    assert_instance_of Array, result
    assert_instance_of Merchant, result.first
  end

  def test_bottom_merchants
    result = @sa.find_bottom_merchants

    assert_instance_of Array, result
    assert_instance_of Array, result.first
    refute_equal @sa.find_upper_merchants, result
  end

  def test_bottom_merchants_by_invoice_count
    result = @sa.bottom_merchants_by_invoice_count

    assert_instance_of Array, result
    assert_instance_of Merchant, result.first
    refute_equal @sa.top_merchants_by_invoice_count, result
  end
end
