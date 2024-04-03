# frozen_string_literal: true

require "tempfile"
class Pixelpress::WeasyPrintRenderer
  def render(html)
    Tempfile.create(["weasyprint", ".pdf"]) do |tempfile|
      command = "#{executable_path} --encoding UTF-8 - #{tempfile.path}"

      error = nil
      process = nil
      Open3.popen3(command) do |stdin, _, stderr, thread|
        stdin.puts html
        stdin.close_write
        error = stderr.read
        process = thread.value
      end

      raise "command failed (exitstatus=#{process.exitstatus}): #{command}\n #{error}" unless process.success?

      return File.read(tempfile.path)
    end
  end

  def version
    `#{executable_path} --version`.chomp.scan(/(\d+\.\d+)/).flatten.first
  end

  private

  def executable_path
    `which weasyprint`.chomp || raise(StandardError, "could not find weasyprint")
  end
end
