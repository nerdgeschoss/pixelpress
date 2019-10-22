class Pixelpress::TestRenderer
  def render(html)
    File.binread(File.join(__dir__, "test.pdf"))
  end
end
