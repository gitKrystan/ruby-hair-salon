require('capybara/rspec')
require('./app')
require('./spec/spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a stylist', {:type => :feature}) do
  it('allows the user to add a new stylist to the database') do
    visit('/')
    fill_in('first_name', :with => 'Julia')
    fill_in('last_name', :with => 'Stiles')
    fill_in('phone', :with => '503-555-4242')
    click_on('Add')
    expect(page).to(have_content('Julia'))
    expect(page).to(have_content('Stiles'))
    expect(page).to(have_content('503-555-4242'))
  end
end

describe('adding a client', {:type => :feature}) do
  it('allows the user to add a new client to the database') do
    create_test_stylist().save()
    visit('/')
    click_link('Clients')
    fill_in('first_name', :with => 'Donald')
    fill_in('last_name', :with => 'Trump')
    fill_in('phone', :with => '503-555-0666')
    select('Julia Stiles')
    click_on('Add')
    expect(page).to(have_content('Donald'))
    expect(page).to(have_content('Trump'))
    expect(page).to(have_content('503-555-0666'))
    expect(page).to(have_content('Julia'))
  end
end
