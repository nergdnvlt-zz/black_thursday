require_relative 'helper_test'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# Test sales analyst class
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './data/items.csv',
      merchants: './data/merchants.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_average_item_price_for_merchant
    result = @sales_analyst.average_item_price_for_merchant(12334185)
    assert result.is_a?(BigDecimal)
  end

  def test_average_average_item_price_for_merchant
    result = @sales_analyst.average_average_price_per_merchant
    assert result.is_a?(BigDecimal)
  end
end
