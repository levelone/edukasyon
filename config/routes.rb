Rails.application.routes.draw do
  namespace :admin do
    get 'courses/index'
  end

  root 'static_pages#index'

  namespace :admin do
    root to: '/admin#index'

    resources :students
    resources :teachers
    resources :courses
    resources :klasses do
      put :enroll, on: :member
      put :unenroll, on: :member
    end
  end

  resources :klasses, only: [:index, :show]
  resources :courses, only: [:index, :show]
end
