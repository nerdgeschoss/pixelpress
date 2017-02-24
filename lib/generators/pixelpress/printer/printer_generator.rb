module Pixelpress
  module Generators
    class PrinterGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      argument :passed_methods, type: :array, default: [], required: false, banner: 'method_name1 method_name2 ...'

      hook_for :test_framework

      def create_custom_printer
        template 'application_printer.rb', 'app/printers/application_printer.rb' unless Rails.root.join("app/printers/application_printer.rb").exist?
        template 'printer.pdf.erb', 'app/views/layouts/printer.pdf.erb' unless Rails.root.join("app/views/layouts/printer.pdf.erb").exist?
        template 'printer.rb', File.join('app/printers', class_path, "#{file_name}_printer.rb")
      end

      def create_custom_printer_views
        passed_methods.each do |method_name|
          @method_name = method_name
          template 'template.pdf.erb', File.join('app/views/printers', class_path, "#{file_name}/#{method_name}.pdf.erb")
        end
      end
    end
  end
end
