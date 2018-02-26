require 'CSV'
require_relative 'invoice_item'

# Creates a invoice item repository to hold merchant info
class InvoiceItemRepository
  attr_reader :engine,
              :invoice_items

  def initialize(filepath, parent = nil)
    @invoice_items = []
    @engine        = parent
    populate_invoices_item(filepath)
  end

  def populate_invoices_item(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoice_items << InvoiceItem.new(data, self)
    end
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
