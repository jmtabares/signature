When(/^I click on report$/) do
  on_page(CommomPage).navigate_to_reports
end

And(/^I see the  report tab$/) do
  on_page(ReportPage).verify_report_page
end

Then(/^I verify the outflow categories and values from the report page are the same from the outflow on the budget table$/) do
  total_inflow = on_page(BudgetPage).get_positive_total_amount
  total_inflow = "$#{total_inflow.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/,'\1,\2')}"
  total_outflow = on_page(BudgetPage).get_negative_total_amount
  total_outflow = "$#{total_outflow.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/,'\1,\2')}"
  map = on_page(BudgetPage).get_category_value_map
  on_page(CommomPage).navigate_to_reports
  on_page(ReportPage).verify_data_from_budget_tab(total_inflow,total_outflow,map)
end