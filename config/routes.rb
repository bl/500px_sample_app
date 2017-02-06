Rails.application.routes.draw do
  root to: "photos#index"
  get 'about' => "static_pages#about"

  resources :photos
end
