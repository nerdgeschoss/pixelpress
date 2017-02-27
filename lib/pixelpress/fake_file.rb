module Pixelpress
  class FakeFile < StringIO
    attr_accessor :original_filename, :content_type

    def initialize(data, options = {})
      @original_filename = options[:original_filename]
      @content_type = options[:content_type]
      super data
    end

    def original_filename
      @original_filename || "document.pdf"
    end

    def content_type
      @content_type || "application/pdf"
    end
  end
end
