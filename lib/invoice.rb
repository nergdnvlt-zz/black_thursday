require 'time'

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
    @customer_id  = data[:customer_id]
    @merchant_id  = data[:merchant_id]
    @status       = data[:status]
    @created_at   = Time.parse(data[:created_at])
    @updated_at   = Time.parse(data[:updated_at])
    @invoice_repo = parent
  end

  def customer
    @invoice_repo.find_by_customer_id(customer_id)
  end
end
