Rails.application.config.autoload_paths << Rails.root.join('app/printers')
Rails.application.config.autoload_paths << Rails.root.join('spec/printers/previews') if Rails.env.development?
