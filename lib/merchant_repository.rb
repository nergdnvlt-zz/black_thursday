require 'CSV'
require_relative 'merchant'

# Creates a merchant repository to hold merchant info
class MerchantRepository
  attr_reader :engine
  def initialize(filepath, parent = nil)
    @merchants = []
    @engine = parent
    populate_merchants(filepath)
  end

  def all
    @merchants
  end

  def populate_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end
  # New method but Brian said to refactor into merchant
  # def find_items_by_merchant_id(id)
  #   items = @engine.items
  #   items.find_all_by_merchant_id(id)
  # end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name_frag)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name_frag.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
