require 'CSV'
require_relative 'customer'

# Creates a repo to hold all customers and their info
class CustomerRepository
  attr_reader :engine,
              :customers

  def initialize(filepath, parent = nil)
    @customers = []
    @engine = parent
    populate_customers(filepath)
  end

  def populate_customers(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @customers << Customer.new(data, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(input_id)
    @customers.find { |customer| customer.id == input_id }
  end

  def find_all_by_first_name(first_frag)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(first_frag.downcase)
    end
  end

  def find_all_by_last_name(last_frag)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(last_frag.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
