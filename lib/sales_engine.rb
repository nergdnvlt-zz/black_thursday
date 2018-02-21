require 'CSV'
require_relative 'merchant_repository'
require_relative 'item_repository'

# Creates a sales engine class to tie everything together
class SalesEngine
  attr_reader :item_csv,
              :merchant_csv,
              :items,
              :merchants

  def initialize(data)
    @item_csv = data[:items]
    @merchant_csv = data[:merchants]
    @items = ItemRepository.new(@item_csv)
    @merchants = MerchantRepository.new(@merchant_csv)
  end

  def self.from_csv(data)
    new(data)
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
