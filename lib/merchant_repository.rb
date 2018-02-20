require 'CSV'
require_relative 'merchant'

# Creates a merchant repository to hold merchant info
class MerchantRepository
  def initialize(filepath)
    @merchants = []
    populate_merchants(filepath)
  end

  def all
    @merchants
  end

  def populate_merchants(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_frag)
    find_all = []
    name_frag = name_frag.downcase
    @merchants.find_all do |merchant|
      find_all << merchant.name if merchant.name.downcase.include?(name_frag)
    end
    find_all
  end
end
