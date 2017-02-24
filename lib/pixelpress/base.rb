require 'action_controller'
require 'weasyprint'

module Pixelpress
  class Base < ActionController::Base
    def html
      render(template) unless @html
      @html
    end

    def pdf
      stream = StringIO.new pdf_data
      stream.singleton_class.class_eval { attr_accessor :original_filename, :content_type }
      stream.original_filename = try(:file_name) || 'document.pdf'
      stream.content_type = 'application/pdf'
      stream
    end

    class << self
      def method_missing(m, *args, &block)
        return super unless respond_to_missing?(m)
        instance = new
        instance.send(m, *args)
        instance.instance_variable_set :@template_name, m.to_s
        instance
      end

      def respond_to_missing?(m, include_private = false)
        return true if new.methods.include?(m)
        super(m, include_private)
      end
    end

    protected

    attr_accessor :template

    def template
      ['printers', self.class.to_s.underscore.sub("_printer", ""), @template_name].join('/')
    end

    private

    def pdf_data
      return '%PDF-1.5' if ENV['RAILS_ENV'] == 'test'
      WeasyPrint.new(html).to_pdf
    end

    def render(template = caller_locations(1, 1)[0].label)
      @html = render_to_string(template)
    end
  end
end
