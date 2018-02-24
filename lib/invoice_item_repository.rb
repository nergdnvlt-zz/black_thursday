require 'CSV'
require_relative 'invoice_item'

# Creates a invoice item repository to hold merchant info
class InvoiceItemRepository
  attr_reader :engine

  def initialize(filepath, parent = nil)
    @invoice_item = []
    @engine       = parent
    populate_invoices_item(filepath)
  end

  def populate_invoices_item(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoice_item << InvoiceItem.new(data, self)
    end
  end

  def all
    @invoice_item
  end
end
