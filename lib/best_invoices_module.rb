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

  def best_invoice_by_quantity
    quantities = {}
    invoices.each do |invoice|
      if invoice.is_paid_in_full?
        quantities[invoice] = invoice.quantity_of_invoices
      end
    end
    highest = quantities.max_by do |_invoice, quantity|
      quantity
    end
    highest[0]
  end

  # def sort_by_quantity
  #   quantities = {}
  #   invoices.each do |invoice|
  #     if invoice.is_paid_in_full?
  #       quantities[invoice] = invoice.quantity_of_invoices
  #     end
  #   end
  #   quantities
  # end
  #
  # def best_invoice_by_quantity
  #   high_quantity = sort_by_quantity.max_by do |_invoice, quantity|
  #     quantity
  #   end
  #   high_quantity[0]
  # end
end
