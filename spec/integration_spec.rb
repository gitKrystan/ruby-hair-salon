require('capybara/rspec')
require('./app')
require('./spec/spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a stylist', {:type => :feature}) do
  it('allows the user to add a new stylist to the database') do
    visit('/')
    click_link('Stylists')
    fill_in('first_name', :with => 'Julia')
    fill_in('last_name', :with => 'Stiles')
    fill_in('phone', :with => '503-555-4242')
    click_on('Add')
    expect(page).to(have_content('Julia'))
    expect(page).to(have_content('Stiles'))
    expect(page).to(have_content('503-555-4242'))
  end
end

describe('viewing a stylist', {:type => :feature}) do
  it('allows the user to view a stylist database entry') do
    test_stylist = create_test_stylist()
    test_stylist.save()
    test_stylist_id = test_stylist.id().to_s()
    test_client = create_test_client()
    test_client.save()
    test_client.add_stylist(test_stylist_id)
    visit('/stylists')
    click_link('Julia')
    expect(page).to(have_content('Julia'))
    expect(page).to(have_content('Stiles'))
    expect(page).to(have_content('503-555-4242'))
    expect(page).to(have_content('Donald'))
  end
end

describe('updating a stylist', {:type => :feature}) do
  it('allows the user to update a stylist database entry') do
    test_stylist = create_test_stylist()
    test_stylist.save()
    test_stylist_id = test_stylist.id().to_s()
    visit('/stylists')
    click_link("update_#{test_stylist_id}")
    fill_in('first_name', :with => 'Jamie')
    fill_in('last_name', :with => 'Styles')
    fill_in('phone', :with => '503-555-4243')
    click_on('Update')
    expect(page).to(have_content('Jamie'))
    expect(page).to(have_content('Styles'))
    expect(page).to(have_content('503-555-4243'))
  end
end

describe('deleting a stylist', {:type => :feature}) do
  it('allows the user to delete a stylist database entry') do
    test_stylist = create_test_stylist()
    test_stylist.save()
    test_stylist_id = test_stylist.id().to_s()
    second_stylist = create_second_stylist()
    second_stylist.save()
    visit('/stylists')
    click_link("update_#{test_stylist_id}")
    click_on('Delete')
    expect(page).not_to(have_content('Jamie'))
    expect(page).to(have_content('Harry'))
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

describe('updating a client', {:type => :feature}) do
  it('allows the user to edit a client in the database') do
    create_test_stylist().save()
    test_client = create_test_client()
    test_client.save()
    test_client_id = test_client.id()
    visit('/clients')
    click_link("update_#{test_client_id}")
    fill_in('first_name', :with => 'Jamie')
    fill_in('last_name', :with => 'Styles')
    fill_in('phone', :with => '503-555-4243')
    click_on('Update')
    expect(page).to(have_content('Jamie'))
    expect(page).to(have_content('Styles'))
    expect(page).to(have_content('503-555-4243'))
  end
end

describe('deleting a client', {:type => :feature}) do
  it('allows the user to delete a client database entry') do
    test_client = create_test_client()
    test_client.save()
    test_client_id = test_client.id().to_s()
    second_client = create_second_client()
    second_client.save()
    visit('/clients')
    click_link("update_#{test_client_id}")
    click_on('Delete')
    expect(page).not_to(have_content('Donald'))
    expect(page).to(have_content('Bernie'))
  end
end
