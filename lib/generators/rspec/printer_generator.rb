module Rspec
  module Generators
    class PrinterGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def create_printer_spec
        template 'printer_spec.rb', File.join('spec/printers', class_path, "#{file_name}_printer_spec.rb")
      end

      def create_printer_previews
        template 'preview.rb', File.join('spec/printers/previews', class_path, "#{file_name}_review.rb")
      end
    end
  end
end
