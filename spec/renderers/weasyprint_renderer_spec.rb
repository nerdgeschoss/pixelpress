
require 'spec_helper'

describe Pixelpress::WeasyPrintRenderer do
  let(:renderer) { Pixelpress::WeasyPrintRenderer.new }
  let (:input) do
    file = Tempfile.new
    file.write <<~HTML
      <html>
        <head>
          <meta name=author content="Bärbel Garçon">
        </head>
        <body>
          <h1>Hêllo Wörld</h1>
        </body>
      </html>
    HTML
    file.rewind
    file
  end

  it "should render html to pdf" do
    reader = PDF::Reader.new(renderer.render(input))

    expect(reader.info[:Author]).to eq("Bärbel Garçon")
    expect(reader.page_count).to eq(1)
    page = reader.pages.sole
    expect(page.text).to eq("Hêllo Wörld")
  end

  context "when the weasyprint binary can't be found" do
    it "raises an error" do
      expect(renderer).to receive(:`).with('which weasyprint').and_return("")

      expect {
        PDF::Reader.new(renderer.render(input))
      }.to raise_error(/Unable to locate weasyprint/)
    end
  end

  context "when weasyprint exits with non-zero exit code" do
    it "reraises a reasonable error" do
      expect(renderer).to receive(:system) do
        Kernel.system("exit 1")
      end

      expect {
        renderer.render(input)
      }.to raise_error(Pixelpress::WeasyPrintRenderer::WeasyPrintExecutionError, "WeasyPrint execution failed with exit code 1")
    end
  end
end
