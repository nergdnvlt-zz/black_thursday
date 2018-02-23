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
    @invoices.find_all do |invoice|
      invoice.customer_id == customer
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
all - returns an array of all known Invoice instances
find_by_id - returns either nil or an instance of Invoice with a matching ID
find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
find_all_by_status - returns e
