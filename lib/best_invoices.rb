require 'bigdecimal'

# Sorts and finds the best invoices
module BestInvoices
  def best_invoice_by_revenue
    revenues = {}
    invoices.each do |invoice|
      revenues[invoice] = invoice.total if invoice.is_paid_in_full?
    end
    highest_revenue = revenues.max_by do |_invoice, revenue|
      revenue
    end
    highest_revenue[0]
  end

  def sorting_invoices_by_quantity
    quantity_hash = {}
    invoices.each do |invoice|
      if invoice.is_paid_in_full?
        quantity_hash[invoice] = invoice.quantity_of_invoices
      end
    end
    quantity_hash
  end

  def best_invoice_by_quantity
    high_quantity = sorting_invoices_by_quantity.max_by do |_invoice, quantity|
      quantity
    end
    high_quantity[0]
  end
end
