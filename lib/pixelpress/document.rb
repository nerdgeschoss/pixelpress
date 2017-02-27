require_relative 'fake_file'

module Pixelpress
  class Document
    attr_reader :html
    attr_reader :file_name

    def initialize(html, renderer, options = {})
      @html = html
      @renderer = renderer
      @file_name = options[:file_name]
    end

    def pdf
      FakeFile.new pdf_data, original_filename: file_name
    end

    private

    attr_accessor :renderer

    def pdf_data
      @pdf_data ||= renderer.render(html)
    end
  end
end
