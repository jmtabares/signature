#!/usr/bin/ruby
require 'watir'
class UnsupportedLanguage < StandardError
end
class MainPage
  include PageObject
  include DataMagic
  page_url FigNewton.env
  link(:register, href: "/en/register/business")
  def verify_registration_link_exists
    puts 'Verifying Registration link exists'
    register_element.wait_until_present.exists?
  end

  def go_to_registration_page
    puts 'navigate to Registration Page'
    register
  end
end
