module Pixelpress
  module Generators
    class PrinterGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def create_printer
        template 'printer.rb', File.join('app/printers', class_path, "#{file_name}_printer.rb")
      end
    end
  end
end