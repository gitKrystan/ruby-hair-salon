class Stylist
  attr_reader(:id, :first_name, :last_name, :phone)

  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @phone = attributes[:phone]
  end

  def save
    result = DB.exec("INSERT INTO stylists (first_name, last_name, phone) \
      VALUES ('#{@first_name}', '#{@last_name}', '#{@phone}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.map_results_to_objects(results)
    objects = []

    results.each() do |result|
      id = result.fetch('id').to_i()
      first_name = result.fetch('first_name')
      last_name = result.fetch('last_name')
      phone = result.fetch('phone')

      objects << Stylist.new({
        :id => id,
        :first_name => first_name,
        :last_name => last_name,
        :phone => phone,
        })
    end

    objects
  end

  def self.all
    results = DB.exec("SELECT * FROM stylists;")
    Stylist.map_results_to_objects(results)
  end

  def self.sort_by(column, direction)
    results = DB.exec("SELECT * FROM stylists ORDER BY #{column} #{direction};")
    Stylist.map_results_to_objects(results)
  end

  def self.find(identification)
    result = DB.exec("SELECT * FROM stylists WHERE id = #{identification};")
      .first()

    id = result.fetch('id').to_i()
    first_name = result.fetch('first_name')
    last_name = result.fetch('last_name')
    phone = result.fetch('phone')

    Stylist.new({
      :id => id,
      :first_name => first_name,
      :last_name => last_name,
      :phone => phone,
      })
  end

  def ==(another_stylist)
    self.id() == another_stylist.id()
  end
end
