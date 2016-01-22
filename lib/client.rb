class Client
  attr_reader(:id, :first_name, :last_name, :phone, :stylist_id)

  def initialize(attributes)
    @id = attributes[:id]
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @phone = attributes[:phone]
    @stylist_id = attributes[:stylist_id]
  end

  def save
    result = DB.exec("INSERT INTO clients (first_name, last_name, phone, stylist_id) \
      VALUES ('#{@first_name}', '#{@last_name}', '#{@phone}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.map_results_to_objects(results)
    objects = []

    results.each() do |result|
      id = result.fetch('id').to_i()
      first_name = result.fetch('first_name')
      last_name = result.fetch('last_name')
      phone = result.fetch('phone')
      stylist_id = result.fetch('stylist_id')

      objects << Client.new({
        :id => id,
        :first_name => first_name,
        :last_name => last_name,
        :phone => phone,
        :stylist_id => stylist_id,
        })
    end

    objects
  end

  def self.all
    results = DB.exec("SELECT * FROM clients;")
    Client.map_results_to_objects(results)
  end

  def self.sort_by(column, direction)
    results = DB.exec("SELECT * FROM clients ORDER BY #{column} #{direction};")
    Client.map_results_to_objects(results)
  end

  def self.find(identification)
    result = DB.exec("SELECT * FROM clients WHERE id = #{identification};")
      .first()

    id = result.fetch('id').to_i()
    first_name = result.fetch('first_name')
    last_name = result.fetch('last_name')
    phone = result.fetch('phone')
    stylist_id = result.fetch('stylist_id')

    Client.new({
      :id => id,
      :first_name => first_name,
      :last_name => last_name,
      :phone => phone,
      :stylist_id => stylist_id,
      })
  end

  def ==(another_client)
    self.id() == another_client.id()
  end

  def stylist
    Stylist.find(@stylist_id.to_i())
  end

  def update(attributes)
    @id = self.id()
    attributes.each() do |attribute|
      column = attribute[0].to_s()
      new_value = attribute[1]

      if new_value.is_a?(String)
        DB.exec("UPDATE clients SET #{column} = '#{new_value}' WHERE id = #{@id}")
      else
        DB.exec("UPDATE clients SET #{column} = #{new_value} WHERE id = #{@id}")
      end
    end
  end
end
