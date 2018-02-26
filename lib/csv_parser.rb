require 'CSV'

module CsvParser
  def csv_parser(file)
    CSV.readlines(file, headers: true, header_converters: :symbol) do |row|
      row
    end
  end
end
