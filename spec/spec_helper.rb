require "rspec"
require "pg"
require "stylist"
require "client"
require "pry"

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stylists *;")
    DB.exec("DELETE FROM clients *;")
  end
end

def create_test_stylist
  Stylist.new({
    :id => nil,
    :first_name => 'Julia',
    :last_name => 'Stiles',
    :phone => "503-555-4242",
    })
end

def create_second_stylist
  Stylist.new({
    :id => nil,
    :first_name => 'Harry',
    :last_name => 'Styles',
    :phone => "503-555-2020",
    })
end

def create_test_client()
  Client.new({
    :id => nil,
    :first_name => 'Donald',
    :last_name => 'Trump',
    :phone => "503-555-0666"
    })
end

def create_second_client()
  Client.new({
    :id => nil,
    :first_name => 'Bernie',
    :last_name => 'Sanders',
    :phone => "503-555-0777"
    })
end
