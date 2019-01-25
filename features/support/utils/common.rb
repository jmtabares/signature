#!/usr/bin/ruby

require 'rubygems'
require 'watir'

# Helper class.
module Common
  include DataMagic

  # method for waiting until ajax elements finishes loading
  # parameter 'how': selector method. i.e.: :id
  # parameter 'what': what to find regarding selector method.
  def self.wait_until_ready(how, what, desc = '', timeout = 5)
    msg = "wait_until_ready: element: #{how}=#{what}"
    msg << " #{desc}" unless desc.empty?
    proc_exists  = proc { @browser.elements(how, what)[0].exists? }
    proc_enabled = proc { @browser.elements(how, what)[0].enabled? }
    start = Time.now.to_f
    if Watir::Wait.until(timeout) { proc_exists.call }
      if Watir::Wait.until(timeout) { proc_enabled.call }
        stop = Time.now.to_f
        format("#{__method__}: start: %.5f  stop: %5f", start, stop)
        format("#{msg} (%.5f seconds)", stop - start)
        true
      else
        puts msg
      end
    else
      failed_to_log(msg)
    end
  rescue
    puts "Unable to #{msg}. '#{$ERROR_INFO}'"
    raise "Unable to #{msg}. '#{$ERROR_INFO}'"
  end

  def self.get_test_data(file, key, value)
    DataMagic.load(file)
    data = DataMagic.yml[key]
    data[value]
  end

  def self.wait_for_new_window(browser, window_title, time_out)
    browser.window(title: window_title.to_s).wait_until_present(timeout = time_out)
  rescue
    puts "Timeout after #{time_out} waiting for window to load. Title: #{window_title}'#{$ERROR_INFO}'"
    raise "Timeout after #{time_out} waiting for window to load. Title: #{window_title}'#{$ERROR_INFO}'"
  end

  def self.validate_bill(currency, amount, bill_link, bill_item, bill_currency)
    validate_bill_link(bill_link)
    validate_bill_item(amount, bill_item)
    validate_bill_currency(currency, bill_currency)
  end

  def self.validate_bill_link(bill_link)
    actual_day = Time.now.utc.strftime('%-d').to_s
    actual_year = Time.now.utc.strftime('%Y').to_s
    puts "Invoice Date #{bill_link.text}"
    raise unless bill_link.text.include? actual_day
    raise unless bill_link.text.include? actual_year
    puts 'Invoice Date Verified'
  end

  def self.validate_bill_item(amount, bill_item)
    puts "Expected Amount #{amount}"
    puts "Invoice Item Line #{bill_item.text}"
    bill_item_amount = bill_item.text.scan(/\d+[\.|\,]\d+/).last
    raise unless amount.to_f == bill_item_amount.sub(',', '.').to_f
    puts 'Invoice Amount Verified'
  end

  def self.validate_bill_currency(currency, bill_currency)
    puts "Invoice Expected Currency #{currency.upcase}"
    puts "Invoice Currency #{bill_currency.upcase}"
    raise unless currency.casecmp(bill_currency).zero?
    puts 'Invoice Currency Verified'
  end

  def self.expected_bill_currency(zone)
    case zone.downcase
    when 'euro'
      currency = 'eur'
    when 'no_euro'
      currency = 'usd'
    when 'vat'
      currency = 'eur'
    else
      raise 'Currency is not valid'
    end
    currency
  end

  def self.get_data_from_array_file(file, key, sub_key)
    data = DataMagic.load(file)
    data[key.strip][sub_key.strip]
  end

  def self.get_array_data(file, key)
    data = DataMagic.load(file)
    data[key.strip]
  end
end
