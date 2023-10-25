
require 'spec_helper'

describe Pixelpress::WeasyPrintRenderer do
  let(:renderer) { Pixelpress::WeasyPrintRenderer.new }

  it "should render html to pdf" do
    expect(renderer.render("<html><body><h1>hello</h1></body></html>")).to start_with("%PDF")
  end
end
