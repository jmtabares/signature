#!/usr/bin/ruby
require 'watir'
class UnsupportedLanguage < StandardError
end

class ReportPage
  include PageObject
  include DataMagic
  def verify_data_from_budget_tab(total_inflow, total_outflow, map)
    inflow = verify_text(total_outflow)
    outflow =verify_text(total_inflow)
    table = verify_map(map)
    raise unless inflow && outflow && table
  end

  def verify_map(map)
    ret =  true
    map.keys.each do |key|
      (ret = ret) && verify_text(key)
      (ret = ret) && verify_text(map[key])
    end
    ret
  end
  def verify_text(value)
    browser.text.include?(value)
  end
end