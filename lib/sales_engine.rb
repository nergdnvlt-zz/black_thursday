require 'CSV'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

# Creates a sales engine class to tie everything together
class SalesEngine
  attr_reader :item_csv,
              :merchant_csv,
              :invoices_csv,
              :items,
              :merchants,
              :invoices

  def initialize(data)
    @item_csv     = data[:items]
    @merchant_csv = data[:merchants]
    @invoices_csv = data[:invoices]
    @items        = ItemRepository.new(@item_csv, self)
    @merchants    = MerchantRepository.new(@merchant_csv, self)
    @invoices     = InvoiceRepository.new(@invoices_csv, self)
  end

  def self.from_csv(data)
    new(data)
  end

  def find_by_id(id)
    @merchants.find_by_id(id)
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_merchant_id(id)
    @merchants.find_by_id(id)
  end

  def find_invoices_by_merchant_id(id)
    @invoices.find_all_by_merchant_id(id)
  end
end
