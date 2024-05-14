module Pixelpress
  class Document
    attr_reader :filename

    def initialize(file, renderer, options = {})
      @file = file
      @renderer = renderer
      @filename = options[:filename]
    end

    def html
      file.read
    end

    def pdf
      @pdf ||= renderer.render(file)
    end

    private

    attr_accessor :renderer, :file
  end
end
