Rails.application.routes.draw do
  devise_for :teachers

  authenticated :teacher do
    root to: "students#index", as: :authenticated_root
  end

  devise_scope :teacher do
    root to: "devise/sessions#new"
    get "teachers/sign_out" => "devise/sessions#destroy"
  end

  resources :students, only: [ :index, :create, :new, :edit, :update, :destroy ]
end
