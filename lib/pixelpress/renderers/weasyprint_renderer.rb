class Pixelpress::WeasyPrintRenderer
  def render(input)
    output = Tempfile.new

    system executable_path, "--encoding", "utf-8", input.path, output.path, exception: true
    return output
  end
  
  def version
    `#{executable_path} --version`.chomp.scan(/(\d+\.\d+)/).flatten.first
  end

  private

  def executable_path
    `which weasyprint`.chomp || raise(StandardError, "could not find weasyprint")
  end
end
