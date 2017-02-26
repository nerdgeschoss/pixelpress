module Pixelpress
  module Generators
    class PrinterGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      argument :passed_methods, type: :array, default: [], required: false, banner: 'method_name1 method_name2 ...'

      check_class_collision suffix: 'Printer'

      hook_for :test_framework

      def create_custom_printer
        template 'application_printer.rb', 'app/printers/application_printer.rb' unless Rails.root.join('app/printers/application_printer.rb').exist?
        # route 'mount Pixelpress::Engine => "rails" if Rails.env.development?' unless engine_mounted?
        template 'printer.pdf.erb', 'app/views/layouts/printer.pdf.erb' unless Rails.root.join('app/views/layouts/printer.pdf.erb').exist?
        template 'printer.rb', File.join('app/printers', class_path, "#{file_name}_printer.rb")
      end

      def create_custom_printer_views
        passed_methods.each do |method_name|
          @method_name = method_name
          template 'template.pdf.erb', File.join('app/views/printers', class_path, "#{file_name}/#{method_name}.pdf.erb")
        end
      end

      private

      def file_name # :doc:
        @_file_name ||= super.gsub(/_printer/i, '')
      end

      def engine_mounted?
        File.open('config/routes.rb').read.include? 'mount Pixelpress::Engine => "rails" if Rails.env.development?'
      end
    end
  end
end
