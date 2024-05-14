require 'spec_helper'

describe Pixelpress::Base do
  let(:renderer) { Pixelpress::TestRenderer.new }
  let(:document) { InvoicePrinter.invoice }

  before(:each) do
    ActionController::Base.append_view_path File.join(spec_root)
    InvoicePrinter.renderer = renderer
  end

  class InvoicePrinter < Pixelpress::Base
    def invoice
    end

    def filename
      'sasha'
    end
  end

  it 'selects the right template' do
    expect(document.html).to include 'Invoice'
  end

  it 'checks if the file name of pdf is correct' do
    expect(document.filename).to eq 'sasha'
  end
end
