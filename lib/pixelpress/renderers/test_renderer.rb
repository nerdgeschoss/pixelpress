class Pixelpress::TestRenderer
  def render(html)
     File.binread(File.expand_path("../../../../spec/fixtures/files/test.pdf", __FILE__))
  end
end
