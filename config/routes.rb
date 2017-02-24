Pixelpress::Engine.routes.draw do
  resources :printers, only: [:index] do
    get ":id", to: "printers#show"
  end
end
