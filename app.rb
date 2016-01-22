require "sinatra"
require "sinatra/reloader"
require "./lib/client"
require "./lib/stylist"
require "pg"
require "pry"

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.sort_by('first_name', 'ASC')
  erb(:stylists)
end

get('/stylists') do
  @stylists = Stylist.sort_by('first_name', 'ASC')
  erb(:stylists)
end

post('/stylists') do
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
  redirect('/stylists')
end

get('/stylists/:id') do
  @id = params[:id].to_i()
  @stylist = Stylist.find(@id)
  @clients = @stylist.clients()
  erb(:stylist)
end

patch('/stylists/:id') do
  id = params[:id].to_i()
  stylist = Stylist.find(id)

  first_name = params[:first_name]
  last_name = params[:last_name]

  if params[:phone].length() > 0
    phone = params[:phone]
  else
    phone = 'NEED PHONE NUMBER'
  end

  unless first_name == stylist.first_name()
    stylist.update({
      :first_name => first_name
      })
  end

  unless last_name == stylist.last_name()
    stylist.update({
      :last_name => last_name
      })
  end

  unless phone == stylist.phone()
    stylist.update({
      :phone => phone
      })
  end

  redirect("/stylists/#{id}")
end

delete('/stylists/:id') do
  id = params[:id].to_i()
  stylist = Stylist.find(id)
  stylist.delete()
  redirect('/stylists')
end

get('/stylists/:id/edit') do
  @id = params[:id].to_i()
  @stylist = Stylist.find(@id)
  erb(:stylist_update)
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

patch('/clients/:id') do
  id = params[:id].to_i()
  client = Client.find(id)

  first_name = params[:first_name]
  last_name = params[:last_name]
  stylist_id = params[:stylist_id].to_i()

  if params[:phone].length() > 0
    phone = params[:phone]
  else
    phone = 'NEED PHONE NUMBER'
  end

  unless first_name == client.first_name()
    client.update({
      :first_name => first_name
      })
  end

  unless last_name == client.last_name()
    client.update({
      :last_name => last_name
      })
  end

  unless phone == client.phone()
    client.update({
      :phone => phone
      })
  end

  unless stylist_id == client.stylist_id()
    if stylist_id > 0
      client.add_stylist(stylist_id)
    end
  end

  redirect("/clients")
end

delete('/clients/:id') do
  id = params[:id].to_i()
  client = Client.find(id)
  client.delete()
  redirect('/clients')
end

get('/clients/:id/edit') do
  @id = params[:id].to_i()
  @client = Client.find(@id)
  if @client.stylist_id()
    @stylist = @client.stylist()
  end
  @stylists = Stylist.sort_by('first_name', 'ASC')
  erb(:client_update)
end
