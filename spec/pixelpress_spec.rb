require "spec_helper"

RSpec.describe Pixelpress do
  it "does select the right template" do
    class TestPrinter < Pixelpress::ApplicationPrinter
      def invoice
      end
    end

    expect(TestPrinter.invoice.send(:template)).to eq "printers/test_printer/invoice"
  end
end
