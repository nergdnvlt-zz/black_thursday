require 'CSV'
require_relative 'transaction'

# Creates an transaction repository to hold item info
class TransactionRepository
  attr_reader :engine

  def initialize(filepath, parent = nil)
    @transactions = []
    @engine       = parent
    populate_item(filepath)
  end

  def all
    @transactions
  end

  def populate_item(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @transactions << Transaction.new(data, self)
    end
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_all_by_result(result)
    @transactions.find_all {|transaction| transaction.result == result}
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
