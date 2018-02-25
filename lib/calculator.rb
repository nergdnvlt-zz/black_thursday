require 'bigdecimal'

# Built to pull out repetition in calculations
module Calculator
  def self.average(num, div)
    (num.to_f / div)
  end

  def self.array_average(array)
    num = array.reduce(:+)
    div = array.size
    average(num, div)
  end

  def self.standard_deviation(array, average)
    Math.sqrt(array.map do |individual|
      (individual - average)**2
    end.reduce(:+) / (array.size - 1)).round(2)
  end
end
