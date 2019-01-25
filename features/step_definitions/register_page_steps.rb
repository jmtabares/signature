And(/^I see the registration form$/) do
  raie unless on_page(RegisterPage).verify_registration_form
end

Then(/^I submit empty form$/) do
 on_page(RegisterPage).submit_form
end

Then(/^I verify all field errors are correct$/) do
  raise unless on_page(RegisterPage).verify_error_messages
end