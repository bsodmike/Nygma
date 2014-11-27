ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path("../../spec/dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

