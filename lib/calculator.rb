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
    @sales_engine.customers.all.each do |customer|
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
    @sales_engine.invoices.find_all_by_customer_id(customer_id)
  end

  def one_time_buyers
    onesies = []
    @sales_engine.customers.all.map do |customer|
      invoices = find_invoices(customer.id)
      paid_invoices = invoices.find_all(&:is_paid_in_full?)
      paid_invoices.delete(false)
      onesies << customer if paid_invoices.length == 1
    end
    onesies
  end
end
