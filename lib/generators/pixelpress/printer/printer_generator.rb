module Pixelpress
  module Generators
    class PrinterGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      argument :passed_methods, type: :array, default: [],  required: false, banner: "method_name1 method_name2 ..."

      def create_custom_printer
        template 'printer.rb', File.join('app/printers', class_path, "#{file_name}_printer.rb")
      end

    end
  end
end