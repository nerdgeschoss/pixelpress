require 'spec_helper'

describe Pixelpress do
  let(:renderer) { Pixelpress::TestRenderer.new }
  let(:document) do 
    file = Tempfile.new
    file.write <<~HTML
      <html>
        <body>
          <h1>Invoice</h1>
        </body>
      </html>
    HTML
    file.rewind
    Pixelpress::Document.new(file, renderer, filename: 'invoice-1')
  end

  it 'checks if the file name of pdf is correct' do
    expect(document.filename).to eq 'invoice-1'
  end

  it 'checks if it is not calling weasyprint when html is called' do
    expect(renderer).not_to receive(:render)
    document.html
  end

  it 'checks if it is calling weasydocument when pdf is called' do
    expect(renderer).to receive(:render)
    document.pdf
  end
end
