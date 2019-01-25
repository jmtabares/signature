#!/usr/bin/ruby
require 'rubygems'
require 'watir'
require 'yaml' # Built in, no gem required
# Module that allows perform operations for the Agroptima creation of users
# outside the application like keept  a record of the created users
module PrincingCalculator
  include DataMagic

  def self.get_vat(zone)
    data = DataMagic.load('pricing.yml')
    vat = 0
    vat = data[:vat] if zone.casecmp('EURO').zero?
    vat.to_f
  end

  def self.get_basic_price(zone)
    data = DataMagic.load('pricing.yml')
    price = 0
    case zone.upcase
    when 'EURO'
      price_value = :eur_basic_price
    when 'NO_EURO'
      price_value = :uss_basic_price
    when 'VAT'
      price_value = :eur_basic_price
    end
    price = data[price_value]
  end

  def self.get_cost_price(zone)
    data = DataMagic.load('pricing.yml')
    price = 0
    case zone.upcase
    when 'EURO'
      price_value = :eur_cost_price
    when 'NO_EURO'
      price_value = :uss_cost_price
    when 'VAT'
      price_value = :eur_cost_price
    end
    price = data[price_value]
  end

  def self.add_vat(price, zone)
    vat = get_vat(zone)
    price * (1 + (vat / 100))
  end

  def self.get_basic_price_vat(zone)
    price = get_basic_price(zone)
    add_vat(price, zone)
  end

  def self.get_cost_price_vat(zone)
    price = get_cost_price(zone)
    add_vat(price, zone)
  end

  def self.get_full_price(zone)
    price = get_basic_price_vat(zone) + get_cost_price_vat(zone)
  end
end
