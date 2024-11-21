Rails.application.routes.draw do
  devise_for :teachers

  authenticated :teacher do
    root to: "students#index", as: :authenticated_root
  end

  devise_scope :teacher do
    root to: "devise/sessions#new"
    get "teachers/sign_out" => "devise/sessions#destroy"
  end

  resources :students do
    member do
      post "perform_simple_job", to: "students#perform_simple_job"
    end
  end
end
