require 'CSV'
require_relative 'item'

# Creates an item repository to hold item info
class ItemRepository
  attr_reader :engine
  def initialize(filepath, parent = nil)
    @items = []
    @engine = parent
    populate_item(filepath)
  end

  def all
    @items
  end

  def populate_item(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data, self)
    end
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(string)
    @items.find_all do |item|
      item.description.downcase.include?(string.downcase)
    end
  end

  def find_all_by_price(input_price)
    @items.find_all do |item|
      item.unit_price == input_price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.member?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant)
    @items.find_all do |item|
      item.merchant_id == merchant
    end
  end

  def find_by_merchant_id(id)
    merchants = @engine.merchants
    merchants.find_by_id(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
