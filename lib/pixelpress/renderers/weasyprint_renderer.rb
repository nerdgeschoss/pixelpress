class Pixelpress::WeasyPrintRenderer
  def render(html)

    command = "#{executable_path} --encoding UTF-8 #{format} - -"

    error = nil
    result = nil
    process = nil
    Open3.popen3(command) do |stdin, stdout, stderr, thread|
      stdin.puts html
      stdin.close_write
      result = stdout.read
      error = stderr.read
      process = thread.value
    end
    raise "command failed (exitstatus=#{process.exitstatus}): #{command}\n #{error}" unless process.success?
    return result
  end
  
  def version
    `#{executable_path} --version`.chomp.then { _1.scan(/(\d+\.\d+)/).flatten.first || _1.scan(/(\d+)/).flatten.first }
  end

  private

  def format
    puts "WeasyPrint version: #{version}"
    "-f pdf" if version.to_f >= 51
  end

  def executable_path
    `which weasyprint`.chomp || raise(StandardError, "could not find weasyprint")
  end
end
