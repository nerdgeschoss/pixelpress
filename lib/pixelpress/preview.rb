module Pixelpress
  class Preview
    def self.all
      Dir[Rails.root.join("spec", "printers", "previews", "**", "*_preview.rb")].map do |file|
        require_dependency file
        file.split("printers/previews/").last.sub(".rb", "").classify.constantize.new
      end
    end

    def printer_name
      self.class.name.underscore.gsub("/", "_")
    end

    def previews
      methods - Object.methods - [:previews]
    end
  end
end
