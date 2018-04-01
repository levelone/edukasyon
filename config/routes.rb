Rails.application.routes.draw do
  root 'static_pages#index'

  namespace :admin do
    root to: '/admin#index'

    resources :students
    resources :teachers
    resources :klasses do
      put :enroll, on: :member
      put :unenroll, on: :member
    end
  end
end
