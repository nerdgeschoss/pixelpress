class Pixelpress::TestRenderer
  def render(_)
     File.open(File.join(__dir__, "test.pdf"))
  end
end
