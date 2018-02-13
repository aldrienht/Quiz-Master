Rails.application.routes.draw do
  get 'sessions/index'

  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    resources :users
  end

  namespace :teacher do
    resources :questions
  end

  get 'dashboard', to: 'dashboard#index'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions


  root to: 'sessions#new'

  match "*path", :to => "application#render_404", via: :all   # renders 404 page when routes not found
end
