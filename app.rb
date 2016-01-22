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
