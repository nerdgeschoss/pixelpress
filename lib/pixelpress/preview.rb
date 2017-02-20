module PixelPress
  class Preview
    def self.all
      Dir[Rails.root.join("spec", "printer_previews", "*.rb")].map do |file|
        file.split("printer_previews/").last.sub(".rb", "").classify.constantize.new
      end
    end

    def previews
      methods - Object.methods - [:previews]
    end
  end
end