require 'spec_helper'

RSpec.describe Pixelpress::Generators::PrinterGenerator do
  path = File.expand_path('../test_destination', __FILE__)
  destination path
  arguments %w(Auth::UserPrinter user_data)

  before(:each) do
    prepare_destination
    allow(Rails).to receive(:root).and_return Pathname.new(path)
    FileUtils.mkdir_p "#{path}/config"
    File.write("#{path}/config/routes.rb", 'mount Pixelpress::Engine => "rails" if Rails.env.development?')
    run_generator
  end

  it 'generates all printer files in app folder' do
    assert_file 'app/printers/application_printer.rb'
  end

  it 'test double suffix printer' do
    assert_file 'app/printers/auth/user_printer.rb'
  end
end
