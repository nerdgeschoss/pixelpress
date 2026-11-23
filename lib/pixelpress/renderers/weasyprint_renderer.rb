class Pixelpress::WeasyPrintRenderer
  class WeasyPrintInstallationError < StandardError; end
  class WeasyPrintExecutionError < StandardError; end

  def render(input, flags: {})
    output = Tempfile.new
    success = system(executable_path, *cli_flags(flags), input.path, output.path)

    unless success
      raise WeasyPrintExecutionError.new("WeasyPrint execution failed with exit code #{$?.exitstatus}")
    end

    return output
  end

  def version
    `#{executable_path} --version`.chomp.scan(/(\d+\.\d+)/).flatten.first
  end

  private

  def cli_flags(flags)
    flags = flags.stringify_keys
    cli_flags = []

    # Default to utf-8 encoding, unless another one is specified
    unless flags.key?("encoding")
      cli_flags += ["--encoding", "utf-8"]
    end

    flags.each do |key, value|
      Array(value).each do
        cli_flags += ["--#{key.dasherize}", value]
      end
    end

    cli_flags
  end

  def executable_path
    path = `which weasyprint`.chomp

    if path.blank?
      raise WeasyPrintInstallationError.new("Unable to locate weasyprint binary. Please make sure it's in your PATH.")
    end

    path
  end
end
