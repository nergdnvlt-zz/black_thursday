# Creates an instance of merchant
class Merchant
  attr_reader :id,
              :name,
              :merchant_repo
  def initialize(data, parent = nil)
    @id = data[:id].to_i
    @name = data[:name]
    @merchant_repo = parent
  end

# New method
  def items
    @merchant_repo.engine.items.find_all_by_merchant_id(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
