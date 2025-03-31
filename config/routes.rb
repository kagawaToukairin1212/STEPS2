Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "static_pages#top"
  get "terms", to: "static_pages#terms", as: :terms
  get "privacy", to: "static_pages#privacy", as: :privacy
  get "coordination", to: "static_pages#coordination", as: :coordination
  get "faq", to: "static_pages#faq", as: :faq
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  resources :users, only: %i[new create edit update]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"
  get "mypage", to: "users#mypage", as: :mypage
  get "profile", to: "users#profile", as: :profile
  get "profile/edit", to: "users#edit", as: :edit_profile
  patch "profile", to: "users#update"

  resources :sheets, only: [ :new, :create, :index, :show, :destroy ] do
    resources :evaluation_scores, only: [ :new, :create, :index, :edit, :update, :destroy ] do
      collection do
        get "edit_by_date"  # 日付ごとに編集するページ
        patch "update_by_date"  # 一括更新処理
        delete "destroy_by_date"
      end
    end
    member do
      get "edit_goals"  # 目標編集ページ
      patch "update_goals"  # 目標更新処理
    end
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

  resources :password_resets, only: [ :new, :create, :edit, :update ]

  if Rails.env.development?
    require "letter_opener_web"
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
