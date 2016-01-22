class Stylist
  attr_reader(:id, :first_name, :last_name, :phone)

  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @phone = attributes[:phone]
  end
end
