Rails.application.routes.draw do
  root 'static_pages#index'

  get '/login',   to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  namespace :admin do
    root to: '/admin#index'

    resources :students
    resources :teachers
    resources :courses
    resources :klasses do
      put :enroll,    on: :member
      put :unenroll,  on: :member
    end
  end

  resources :students
  resources :teachers, only: [:index, :show]
  resources :courses, only: [:index, :show]
  resources :klasses, only: [:show] do
    put :enroll,    on: :member
    put :unenroll,  on: :member
  end
end
