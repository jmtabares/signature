#!/usr/bin/ruby
require 'watir'
class UnsupportedLanguage < StandardError
end
class CommomPage
  include PageObject
  include DataMagic
  link(:budget, :href => '/budget')
  link(:reports, :href => '/reports')

  def navigate_to_budget
    budget
  end

  def navigate_to_reports
    reports
  end
end