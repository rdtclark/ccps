Rails.application.routes.draw do
  resources :jobs
  resources :organisations do
    member do
      get '/about' => 'organisations#about'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
