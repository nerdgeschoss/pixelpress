require 'spec_helper'

describe Pixelpress do
  before(:all) { ActionController::Base.view_paths << File.join(spec_root) }

  class Invoice
    include ActiveModel::Model

    attr_accessor :company_invoice
  end

  class InvoicePrinter < Pixelpress::Base
    # layout "pdf"

    def invoice; end

    def file_name
      'sasha'
    end
  end

  it 'selects the right template' do
    expect(InvoicePrinter.invoice.send(:template)).to eq 'printers/invoice_printer/invoice'
  end

  it 'does output some html' do
    expect(InvoicePrinter.invoice.html).to include 'sasha'
  end

  it 'checks if the file name of pdf is correct' do
    printer = InvoicePrinter.invoice.pdf
    expect(printer.original_filename).to eq 'sasha'
  end

  it 'checks if render method renders html' do
    html = InvoicePrinter.invoice.send :render, 'printers/invoice_printer/invoice'
    expect(html).to include '<html>'
  end

  it 'checks if it is calling weasyprinter when html is called' do
    result = InvoicePrinter.invoice.html
    expect(result).not_to include '%PDF-1.5'
  end
end
