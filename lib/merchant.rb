# Creates an instance of merchant
class Merchant
  attr_reader :id,
              :name
  def initialize(data)
    @id = data.fetch(:id).to_i
    @name = data.fetch(:name)
  end
end
