require 'weasyprint'

class Pixelpress::WeasyPrintRenderer
  def render(html)
    WeasyPrint.new(html).to_pdf
  end
end
