Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :patients do
    resources :moods
    resources :nutrition_entries
    resources :exercise_entries
    resources :journal_entries
    resources :appointments
    resources :mindfulness_activities
    resources :sleep_entries
    resources :medication_entries
    resources :social_interactions
    resources :patterns
  end

  resources :therapists, only: [:index, :show, :create, :update, :destroy] 
end
