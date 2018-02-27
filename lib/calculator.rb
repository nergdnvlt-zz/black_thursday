require 'bigdecimal'

# Built to pull out repetition in calculations
module Calculator
  def self.average(num, div)
    (num.to_f / div)
  end

  def self.array_average(array)
    num = array.reduce(:+)
    div = array.size
    average(num, div)
  end

  def self.standard_deviation(array, average)
    Math.sqrt(array.map do |individual|
      (individual - average)**2
    end.reduce(:+) / (array.size - 1)).round(2)
  end

  def top_buyers(count = 20)
    hash = {}
    @engine.customers.all.each do |customer|
      buyers_hash(customer, hash)
    end
    top_customers = hash.keys.max(count)
    top_customers.map { |key| hash[key] }
  end

  def buyers_hash(customer, hash)
    invoices = find_invoices(customer.id)
    paid_invoices = invoices.find_all(&:is_paid_in_full?)
    invoice_costs = paid_invoices.map(&:total)
    hash[invoice_costs.reduce(:+).to_f] = customer
  end

  def find_invoices(customer_id)
    @engine.invoices.find_all_by_customer_id(customer_id)
  end

  def one_time_buyers
    onesies = []
    @engine.customers.all.map do |customer|
      invoices = find_invoices(customer.id)
      paid_invoices = invoices.find_all(&:is_paid_in_full?)
      paid_invoices.delete(false)
      onesies << customer if paid_invoices.length == 1
    end
    onesies
  end

  def one_time_buyers_top_items
    customers = one_time_buyers
    hash = Hash.new(0)
    customers.each do |customer|
      find_top_items(customer, hash)
    end
    [hash.key(hash.values.sort.last)]
  end

  def find_top_items(customer, hash)
    invoices = customer.fully_paid_invoices
    invoices.each do |invoice|
      invc_items = @engine.invoice_items.find_all_by_invoice_id(invoice.id)
      invc_items.each do |invoice_item|
        item = @engine.items.find_by_id(invoice_item.item_id)
        hash[item] += invoice_item.quantity
      end
    end
  end

  def finding_invoice_items(id)
    invoice_items = {}
    customer = @engine.customers.find_by_id(id)
    customer.invoices.map do |invoice|
      invoice_items[invoice] = invoice.quantity_of_invoices
    end
    invoice_items
  end

  def top_merchant_for_customer(id)
    high = finding_invoice_items(id).max_by do |_invoice, orders|
      orders
    end
    high[0].merchant
  end
end
