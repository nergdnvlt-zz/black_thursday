require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require_relative '../lib/invoice_item_repository'

# Tests the Invoice Item Repository
class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    @invoice_item_repo = InvoiceItemRepository.new('./data/invoice_items.csv')
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end
end
