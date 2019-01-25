#!/usr/bin/ruby
require 'watir'
class UnsupportedLanguage < StandardError
end
class BudgetPage
  include PageObject
  include DataMagic
  page_url FigNewton.env
  table(:items, xpath: ".//table[@class='opmhI']")
  select_list(:category_list, name: 'categoryId')
  text_field(:description_field , name: 'description')
  text_field(:value_field , name: 'value')
  button(:add, xpath:".//*/button[contains(text(),'Add')]")
  def verify_main_table_exists
    puts 'Verifying Bugdet tab  page'
    items_element.wait_until_present.exists?
  end

  def verify_work_balance
    total_inflow = get_positive_total_amount
    total_outflow = get_negative_total_amount
    work_balance =  (total_inflow - total_outflow).round(2)
    work_balance *= -1 unless work_balance >= 0
    verify_total_value(work_balance.to_s)
    # return @browser.element(xpath:".//*/div[contains(text(),'#{work_balance.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/,'\1,\2')}')]").present?
  end

  def verify_inflow
    total_inflow = get_positive_total_amount.round(2)
    verify_total_value(total_inflow.to_s)
  end

  def verify_outflow
    total_outflow = get_negative_total_amount.round(2)
    verify_total_value(total_outflow.to_s)
  end

  def verify_total_value(total_value)
    value_to_verify = ".//*/div[contains(text(),'#{total_value.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/, '\1,\2')}')]"
    #verify_total_value("#{total_value.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/, '\1,\2')}")
    @browser.element(xpath: value_to_verify).present?
  end

  def get_positive_total_amount
    sum = 0.0
    values = @browser.elements(xpath: './/*/table/tbody/tr/td[3]/div[2]')
    values.each do |value|
      next if value.text.include? '-$'

      new_value = value.text.sub('$', '')
      new_value = new_value.sub(',', '')
      sum = sum.to_f + new_value.to_f
    end
    sum
  end

  def get_negative_total_amount
    sum = 0.0
    values = @browser.elements(xpath: './/*/table/tbody/tr/td[3]/div[2]')
    values.each do |value|
      next unless value.text.include? '-$'

      new_value = value.text.sub('-$', '')
      new_value = new_value.sub(',', '')
      sum = sum.to_f + new_value.to_f
    end
    sum
  end

  def get_category_value_map
      map = {}
      rows = @browser.elements(xpath: './/*/table/tbody/tr')
      rows.each do |row|
        add_category_value_tuple(map, row)
      end
      map
  end
  def delete_all_items
    first_row = browser.element(xpath:".//*[@id='root']/main/section/table/tbody/tr[1]")
    while first_row.exists?
      first_row.click
      button = browser.button(xpath:".//*/form/div[4]/button[3]")
      button.click
    end

  end
  def add_item(category,description,value)
    @browser.select_list(xpath: ".//select[@name='categoryId']").select(category)
    @browser.input(xpath: ".//input[@name='description']").send_keys description
    @browser.input(xpath: ".//input[@name='value']").send_keys value
    add
  end
  private

  def convert_value_to_float(value)
    actual_value = value.sub('$', '')
    actual_value = actual_value.sub(',', '')
    actual_value.to_f
  end

  def add_category_value_tuple(map, row)
    category = row.cells[0].text
    unless category.casecmp('income').zero?
      value = row.cells[2].text.sub('-', '')
      if map.key? category
        actual_value = convert_value_to_float(map[category])
        value_to_add = convert_value_to_float(value)
        sum = actual_value + value_to_add
        value = "$#{sum.to_s.gsub(/(\d)(?=\d{3}+(?:\.|$))(\d{3}\..*)?/, '\1,\2')}"
      end
      map[category]=value
    end
  end
end
