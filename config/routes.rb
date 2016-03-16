Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    scope module: "company" do
      resources :plans
      root to: 'dashboard#index', as: 'dashboard'
    end
    resource :company, only: [:new, :create], controller: 'company'
  end

  unauthenticated do
    root to: 'landing_page#index', as: :root
  end
end


