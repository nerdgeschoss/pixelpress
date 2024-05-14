module Pixelpress
  module Rendering
    extend ActiveSupport::Concern
    
    included do
      class_attribute :renderer, default: WeasyPrintRenderer.new

      def document
        @document ||= begin
          file = Tempfile.new
          file.write render_to_string(template)
          file.rewind
          Document.new file, renderer, filename: (try(:filename) || try(:file_name))
        end
      end

      protected
      
      delegate :renderer, to: :class

      def template
        ['printers', controller_path.sub('_printer', ''), @template_name].join('/')
      end
    end
  end
end
