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

  def clients
    id = @id.to_i()
    results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{id};")
    Client.map_results_to_objects(results)
  end

  def update(attributes)
    @id = self.id()
    attributes.each() do |attribute|
      column = attribute[0].to_s()
      new_value = attribute[1]
      DB.exec("UPDATE stylists SET #{column} = '#{new_value}' WHERE id = #{@id}")
    end
  end

  def delete
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
    DB.exec("UPDATE clients SET stylist_id = NULL WHERE stylist_id = #{self.id()};")
  end
end
