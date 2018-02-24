require_relative 'helper_test'
require_relative '../lib/calculator'

# Tests accuracy of standard deviation calculations
class CalculatorTest < Minitest::Test
  def test_average
    result = Calculator.average(10, 2)
    assert_equal 5.0, result
  end

  def test_array_average
    array = [10, 2, 38, 23, 38, 23, 21]
    result = Calculator.array_average(array)
    assert_equal 22, result
  end

  def test_standard_deviation
    array = [10, 2, 38, 23, 38, 23, 21]
    average = Calculator.array_average(array)
    result = Calculator.standard_deviation(array, average)

    assert_equal 13.27, result
  end
end
