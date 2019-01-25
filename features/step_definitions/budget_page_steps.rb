Given(/^I open the main page$/) do
  puts 'Navigate to Main Page'
  visit_page(BudgetPage)
end

Then(/^I see the budget tab$/) do
  raise unless on_page(BudgetPage).verify_main_table_exists
end

And(/^I verify that work balance value is correct$/) do
  raise unless on_page(BudgetPage).verify_work_balance
end

And(/^I verify the total inflow value represents the sum of positive values on table$/) do
  raise unless on_page(BudgetPage).verify_inflow
end

And(/^I verify the total outflow value represents the sum of negative values on table$/) do
  raise unless on_page(BudgetPage).verify_outflow
end

When(/^I click on budget$/) do
  on_page(CommomPage).navigate_to_budget
end

And(/^I delete all items on table$/) do
  on_page(BudgetPage).delete_all_items
end

And(/^I add a new "(.*)" with "(.*)" and "(.*)"$/) do |category, description, value|
  on_page(BudgetPage).add_item(category,description,value)
end