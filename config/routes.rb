Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    resources :users, except: [:show]
  end

  namespace :teacher do
    resources :questions, except: [:show]

    get 'student_exam_results/:student_id', to: 'students#exam_results', as: 'student_exam_results'
    resources :students, only: [:index]
  end

  namespace :student do
    get 'examinations', to: 'examinations#index'
    get 'take_exam/:teacher_id', to: 'examinations#take_exam', as: 'take_exam'
    post 'submit_exam', to: 'examinations#submit_exam', as: 'submit_exam'
    get 'exam_result/:teacher_id', to: 'examinations#exam_results', as: 'exam_results'
  end

  get 'dashboard', to: 'dashboard#index'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :sessions

  root to: 'sessions#new'

  match "*path", :to => "application#render_404", via: :all   # renders 404 page when routes not found
end
