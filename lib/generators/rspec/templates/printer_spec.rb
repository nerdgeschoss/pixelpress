require '<%= File.exists?('spec/rails_helper.rb') ? 'rails_helper' : 'spec_helper' %>'

describe <%= class_name %>Printer do
  it "should be tested" do
    pending("implement your rspec tests")
  end
end