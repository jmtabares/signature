#!/usr/bin/ruby
require 'rubygems'
require 'watir'
require 'yaml' # Built in, no gem required
# Module that allows perform operations for the Agroptima creation of users
# outside the application like keept  a record of the created users
module AccountCreationHelper
  def save_created_account(new_account)
    data = YAML.load_file Dir.pwd + '/config/data/created_accounts.yml'
    data[:accounts][:created_accounts] = [] if data[:accounts][:created_accounts].nil?
    data = YAML.load_file Dir.pwd + '/config/data/created_accounts.yml'
    data[:accounts][:created_accounts] = [] if data[:accounts][:created_accounts].nil?
    data[:accounts][:created_accounts].push new_account
    File.open(Dir.pwd + '/config/data/created_accounts.yml', 'w') { |f| f.write data.to_yaml } # Store
  end

  def update_login_data
    created_account = get_last_created_account
    yaml_file = YAML.load_file Dir.pwd + '/config/data/login_data.yml'
    yaml_file['auto_created_account']['login'] = created_account
    File.open(Dir.pwd + '/config/data/login_data.yml', 'w') { |f| YAML.dump(yaml_file, f) }
  end

  def get_last_created_account
    data = YAML.load_file Dir.pwd + '/config/data/created_accounts.yml'
    data[:accounts][:created_accounts].last
  end
end
