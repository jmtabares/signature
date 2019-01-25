#!/usr/bin/ruby
require 'watir'
class UnsupportedLanguage < StandardError
end

class RegisterPage
  include PageObject
  include DataMagic
  button(:sign_now, id:'register_submit')
  checkbox(:terms, xpath: './/input[@class="info-links-checkbox"]')
  text_field(:first_name, id:'register_first_name')
  text_field(:last_name, id:'register_last_name')
  text_field(:company, id:'register_company')
  text_field(:job, id:'register_job_title')
  text_field(:phone, id:'register_phone')
  text_field(:email, id:'register_email')
  text_field(:password, id:'register_password')

  def submit_form
    check_terms
    sign_now
  end
  def verify_registration_form
    first_name_element.wait_until_present.exists? && last_name_element.wait_until_present.exists? &&
        company_element.wait_until_present.exists? && job_element.wait_until_present.exists? &&
        phone_element.wait_until_present.exists? && email_element.wait_until_present.exists? &&
        password_element.wait_until_present.exists?

  end
  def verify_error_messages
    error_messages=['Invalid name', 'Invalid surname',  'The company can\'t be empty', 'The job title can\'t be empty' ,
                    'The phone can\'t be empty' , 'The email is invalid']
    error_messages.each do |message|
      raise unless verify_text message
    end
  end
  def verify_text(value)
    browser.text.include?(value)
  end
end