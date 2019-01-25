Given(/^I open the main page$/) do
  puts 'Navigate to Main Page'
  visit_page(MainPage)
end

Then(/^I see the registration link$/) do
  raise unless on_page(MainPage).verify_registration_link_exists
end

Then(/^I click registration link$/) do
  on_page(MainPage).go_to_registration_page
end