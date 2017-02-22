require "spec_helper"


describe Pixelpress do

  before(:all) {  ActionController::Base.view_paths << File.join(spec_root) }

  class Invoice 
    include ActiveModel::Model

    attr_accessor :company_invoice
  end

  class InvoicePrinter < Pixelpress::Base
    # layout "pdf"

    def invoice 
    end
  end

  it "selects the right template" do
    expect(InvoicePrinter.invoice.send(:template)).to eq "printers/invoice_printer/invoice"
  end

  it "does output some html" do
    expect(InvoicePrinter.invoice.html).to include "<html"
  end
end
