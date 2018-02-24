require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :invoice_repo

  def initialize(data, parent = nil)
    @id                = data[:id].to_i
    @item_id           = data[:item_id]
    @invoice_id        = data[:invoice_id]
    @quantity          = data[:quantity]
    @created_at        = Time.parse(data[:created_at])
    @updated_at        = Time.parse(data[:updated_at])
    @invoice_item_repo = parent
  end
end
