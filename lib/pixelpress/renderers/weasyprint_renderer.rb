class Pixelpress::WeasyPrintRenderer
  def render(html)

    command = [executable_path, "-", "-"].shelljoin

    result = IO.popen(command, "wb+") do |pdf|
      pdf.puts(html)
      pdf.close_write
      pdf.gets(nil)
    end

    # $? is thread safe per http://stackoverflow.com/questions/2164887/thread-safe-external-process-in-ruby-plus-checking-exitstatus
    raise "command failed (exitstatus=#{$?.exitstatus}): #{command}" if result.to_s.strip.empty? || !$?.success?
    return result
  end
  
  def version
    `#{executable_path} --version`.chomp.scan(/(\d+\.\d+)/).flatten.first
  end

  private

  def executable_path
    `which weasyprint`.chomp || raise(StandardError, "could not find weasyprint")
  end
end
