require 'bundler/setup'
require 'pixelpress'
require 'pixelpress/base'
require 'pry'
require 'active_model'
require 'generator_spec'
require 'rails/generators'
require 'rails/generators/named_base'
require 'generators/pixelpress/printer/printer_generator'
require 'pathname'
require 'open3'
require 'pdf-reader'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def spec_root
  File.dirname(__FILE__)
end
