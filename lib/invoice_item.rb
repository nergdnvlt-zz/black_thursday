require 'bigdecimal'
require 'time'

# Creates an instance of an invoice item
class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :created_at,
              :updated_at,
              :unit_price,
              :invoice_item_repo

  def initialize(data, parent = nil)
    @id                = data[:id].to_i
    @item_id           = data[:item_id].to_i
    @invoice_id        = data[:invoice_id].to_i
    @quantity          = data[:quantity].to_i
    @created_at        = Time.parse(data[:created_at])
    @updated_at        = Time.parse(data[:updated_at])
    @unit_price        = BigDecimal.new(data[:unit_price]) / 100
    @invoice_item_repo = parent
  end

  def unit_price_in_dollars
    @unit_price.to_f.round(2)
  end
end
