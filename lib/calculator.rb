# Built to pull out repitition in calculations
module Calculator
  def self.average(num, div)
    num.to_f / div
  end

  def self.array_average(array)
    array.reduce(:+) / array.size
  end

  def self.standard_deviation(array, average)
    Math.sqrt(
      array.reduce(0) do |sum, individual|
        sum + (individual - average)**2
      end / (array.count - 1)
    ).round(2)
  end
end
