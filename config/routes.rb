Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "static_pages#top"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  get "mypage", to: "users#mypage", as: :mypage
  get "profile", to: "users#profile", as: :profile
  resources :sheets, only: [ :new, :create, :index, :show ] do
    resources :evaluation_scores, only: [ :new, :create, :index ]
  end
  resources :questions, only: [ :index, :new, :create, :show, :edit, :update, :destroy ] do
    member do
      patch :update_status  # 解決済みにするアクション
    end
    collection do
      get "unresolved"  # 未解決の質問
      get "resolved"    # 解決済みの質問
      get "my_questions" # 自分の質問
      get "answered"    # 自分が回答した質問
    end
    resources :question_responses, only: [ :create, :edit, :update, :destroy ]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  

  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
