class Pixelpress::WeasyPrintRenderer
  class WeasyPrintInstallationError < StandardError; end
  class WeasyPrintExecutionError < StandardError; end

  def render(input)
    output = Tempfile.new

    success = system(executable_path, "--encoding", "utf-8", input.path, output.path)

    unless success
      raise WeasyPrintExecutionError.new("WeasyPrint execution failed with exit code #{$?.exitstatus}")
    end

    return output
  end

  def version
    `#{executable_path} --version`.chomp.scan(/(\d+\.\d+)/).flatten.first
  end

  private

  def executable_path
    path = `which weasyprint`.chomp

    if path.blank?
      raise WeasyPrintInstallationError.new("Unable to locate weasyprint binary. Please make sure it's in your PATH.")
    end

    path
  end
end
