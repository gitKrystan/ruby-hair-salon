require "sinatra"
require "sinatra/reloader"
require "./lib/client"
require "./lib/stylist"
require "pg"
require "pry"

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.sort_by('first_name', 'ASC')
  erb(:index)
end

post('/') do
  first_name = params[:first_name]
  last_name = params[:last_name]


  if params[:phone].length() > 0
    phone = params[:phone]
  else
    phone = 'NEED PHONE NUMBER'
  end

  Stylist.new({
    :id => nil,
    :first_name => first_name,
    :last_name => last_name,
    :phone => phone,
    }).save()
  redirect('/')
end

get('/clients') do
  @clients = Client.sort_by('first_name', 'ASC')
  @stylists = Stylist.sort_by('first_name', 'ASC')
  erb(:clients)
end

post('/clients') do
  first_name = params[:first_name]
  last_name = params[:last_name]
  stylist_id = params[:stylist_id].to_i()

  if params[:phone].length() > 0
    phone = params[:phone]
  else
    phone = 'NEED PHONE NUMBER'
  end

  client = Client.new({
    :id => nil,
    :first_name => first_name,
    :last_name => last_name,
    :phone => phone,
    :stylist_id => nil,
    })
  client.save()

  if stylist_id > 0
    client.add_stylist(stylist_id)
  end
  
  redirect('/clients')
end
