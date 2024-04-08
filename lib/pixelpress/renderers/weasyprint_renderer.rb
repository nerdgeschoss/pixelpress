# frozen_string_literal: true

require "tempfile"
require 'open3'

class Pixelpress::WeasyPrintRenderer
  # def render(html)

  #   command = "#{executable_path} --encoding UTF-8 - -"

  #   error = nil
  #   result = nil
  #   process = nil
  #   Open3.popen3(command) do |stdin, stdout, stderr, thread|
  #     stdin.puts html
  #     stdin.close_write
  #     result = stdout.read
  #     error = stderr.read
  #     process = thread.value
  #   end
  #   raise "command failed (exitstatus=#{result.exitstatus}): #{command}\n #{error}" unless process.success?
  #   return result
  # end

  # def render(html)
  #   Tempfile.create(['input', '.html']) do |html_file|
  #     html_file.write(html)
  #     html_file.flush

  #     Tempfile.create(['output', '.pdf']) do |pdf_file|
  #       command = "#{executable_path} --encoding UTF-8 #{html_file.path} #{pdf_file.path}"
  #       execute_command(command)

  #       return File.read(pdf_file.path)
  #     end
  #   end
  # end

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

    File.write('temp.html', html)
    command = "#{executable_path} --encoding UTF-8 temp.html temp.pdf"
    IO.popen(command, 'wb+') do |pdf|
      # pdf.puts html
      # pdf.close_write
      pdf.gets(nil)
    end
    # result = File.read('temp.pdf')
    # return result
  end

  def version
    `#{executable_path} --version`.chomp.scan(/(\d+\.\d+)/).flatten.first
  end

  private

  def execute_command(command)
    output = `#{command}`
    raise StandardError, "Command failed: #{output}" unless $?.success?
  end

  def executable_path
    `which weasyprint`.chomp || raise(StandardError, "could not find weasyprint")
  end
end
