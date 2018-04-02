Rails.application.routes.draw do
  root 'static_pages#index'

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

  resources :courses,   only: [:index, :show]
  resources :klasses,   only: [:show]
  resources :teachers,  only: [:index, :show]
end
