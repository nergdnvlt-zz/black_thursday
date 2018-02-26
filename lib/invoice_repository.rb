require 'CSV'

require_relative 'invoice'

# Creates a merchant repository to hold merchant info
class InvoiceRepository
  attr_reader :engine

  def initialize(filepath, parent = nil)
    @invoices = []
    @engine = parent
    populate_invoices(filepath)
  end

  def populate_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer)
    @invoices.find_all { |invoice| invoice.customer_id == customer }
  end

  def find_all_by_merchant_id(merchant)
    @invoices.find_all { |invoice| invoice.merchant_id == merchant }
  end

  def find_all_by_status(stat)
    @invoices.find_all { |invoice| invoice.status == stat }
  end

  def find_merchant_by_merchant_id(id)
    @engine.find_merchant_by_merchant_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    @engine.find_invoice_items_by_invoice_id(id)
  end

  def find_item_by_id(item_id)
    @engine.find_item_by_id(item_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    @engine.find_transactions_by_invoice_id(invoice_id)
  end

  def find_customers_by_customer_id(id)
    @engine.find_customers_by_customer_id(id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
