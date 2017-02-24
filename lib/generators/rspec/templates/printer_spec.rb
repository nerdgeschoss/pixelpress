require '<%= File.exists?('spec/rails_helper.rb') ? 'rails_helper' : 'spec_helper' %>'

describe <%= class_name %>Printer, pending: true do
  it "should be tested" do
    raise "implement your rspec tests"
  end
end
