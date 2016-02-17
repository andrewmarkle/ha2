Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}

  devise_scope :user do
    authenticated :user do
      root to: 'dashboard#index', as: 'dashboard'
      resources :plans
    end
    resource :company, only: [:new, :create, :update, :edit], controller: 'company'

    unauthenticated do
      root to: 'landing_page#index', as: :root
    end
  end
end
