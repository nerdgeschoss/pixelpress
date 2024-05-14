
require 'spec_helper'

describe Pixelpress::WeasyPrintRenderer do
  let(:renderer) { Pixelpress::WeasyPrintRenderer.new }
  let (:input) do 
    file = Tempfile.new
    file.write("<html><body><h1>hello</h1></body></html>")
    file.rewind
    file
  end

  it "should render html to pdf" do
    expect(renderer.render(input).read).to start_with("%PDF")
  end
end
