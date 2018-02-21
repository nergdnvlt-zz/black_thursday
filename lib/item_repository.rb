require 'cvs'
require_relative '../lib/item'

class ItemRepository
  def initialize(filepath)
     @items = []
     populate_item(filepath)
  end

  # def all
  #   @items
  # end

  def populate_item(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @items << item.new(data)
    end
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  # def find_by_name
  #
  # end
  #
  # def find_all_with_description
  #
  # end
  #
  # def find_all_by_price
  #
  # end
  #
  # def find_all_by_price_range
  #
  # end
  #
  # def find_all_by_merchant_id
  #
  # end

end
