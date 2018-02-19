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
end
