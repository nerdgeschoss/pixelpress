Rails.application.config.autoload_paths << Rails.root.join('app', 'printers')
Rails.application.config.autoload_paths << Rails.root.join('spec', 'printer', 'previews') if Rails.env.development?
