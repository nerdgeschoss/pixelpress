module Printer
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def copy_application_policy
        template 'sasha.rb', 'app/sasha.rb'
      end
    end
  end
end
