class Pixelpress::TestRenderer
  def render(html)
     File.binread(__dir__, "test.pdf")
  end
end
