module Pixelpress
  module Rendering
    extend ActiveSupport::Concern
    
    included do
      class_attribute :renderer, default: WeasyPrintRenderer.new

      def document
        @document ||= Document.new render_to_string(template), renderer, file_name: try(:file_name)
      end

      protected
      
      delegate :renderer, to: :class

      def template
        ['printers', controller_path.sub('_printer', ''), @template_name].join('/')
      end
    end
  end
end
