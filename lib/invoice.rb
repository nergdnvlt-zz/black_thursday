require 'time'

# Class to hold all the invoice info in a single object
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repo

  def initialize(data, parent = nil)
    @id           = data[:id].to_i
    @customer_id  = data[:customer_id].to_i
    @merchant_id  = data[:merchant_id].to_i
    @status       = data[:status].to_sym
    @created_at   = Time.parse(data[:created_at])
    @updated_at   = Time.parse(data[:updated_at])
    @invoice_repo = parent
  end

  def merchant
    @invoice_repo.find_merchant_by_merchant_id(merchant_id)
  end

  def invoice_items(id = 1)
    @invoice_repo.find_invoice_items_by_invoice_id(id)
  end

  def items
    invoice_items = @invoice_repo.find_invoice_items_by_invoice_id(id)
    invoice_items.map do |invoice_item|
      invoice_repo.find_item_by_id(invoice_item.item_id)
    end.compact
  end

  def transactions
    @invoice_repo.find_transactions_by_invoice_id(id)
  end

  def customer
    @invoice_repo.find_customers_by_customer_id(@customer_id)
  end

  def is_paid_in_full?
    fulfilled = transactions.find do |transaction|
      transaction.result == 'success'
    end
    return true if fulfilled
    false
  end

  def total
    invoice_items = @invoice_repo.find_invoice_items_by_invoice_id(id)
    invoice_items.reduce(0) do |total, invoice_item|
      total + invoice_item.unit_price * invoice_item.quantity
    end.round(2)
  end

  def quantity_of_invoices
    invoice_items = invoice_repo.find_invoice_items_by_invoice_id(id)
    invoice_items.map do |invoice_item|
      invoice_item.quantity.to_i
    end.reduce(:+)
  end
end
