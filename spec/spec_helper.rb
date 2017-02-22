require 'bundler/setup'
require 'pixelpress'
require 'pixelpress/base'
require 'pry'
require 'active_model'
require 'weasyprint'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def spec_root
  File.dirname(__FILE__)
end
