module Pixelpress
  module Rendering
    module ClassMethods
      attr_writer :default_renderer
      def default_renderer
        @default_renderer ||= WeasyPrintRenderer.new
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def document
      @document ||= Document.new render_to_string(template), renderer, file_name: try(:file_name)
    end

    protected

    def renderer
      @renderer || self.class.default_renderer
    end

    def template
      ['printers', controller_path.sub('_printer', ''), @template_name].join('/')
    end
  end
end
