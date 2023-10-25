require 'spec_helper'

describe Pixelpress do
  let(:renderer) { TestRenderer.new }

  before(:each) do
    ActionController::Base.append_view_path File.join(spec_root)
    InvoicePrinter.renderer = renderer
  end

  class InvoicePrinter < Pixelpress::Base
    def invoice
    end

    def file_name
      'sasha'
    end
  end

  class TestRenderer
    attr_accessor :called

    def render(html)
      self.called = true
      ""
    end
  end

  it 'selects the right template' do
    expect(InvoicePrinter.invoice.html).to include 'Invoice'
  end

  it 'checks if the file name of pdf is correct' do
    printer = InvoicePrinter.invoice.pdf
    expect(printer.original_filename).to eq 'sasha'
  end

  it 'checks if it is calling weasyprinter when html is called' do
    InvoicePrinter.invoice.html
    expect(renderer.called).to be_falsy
  end

  it 'checks if it is calling weasyprinter when pdf is called' do
    InvoicePrinter.invoice.pdf
    expect(renderer.called).to be_truthy
  end
end
