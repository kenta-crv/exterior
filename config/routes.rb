Rails.application.routes.draw do
  #取引先アカウント
  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions'
  }
  resources :clients do
    member do
      post :disclose
      post :send_mail
      post :send_mail_start #開始日の送信
      get "conclusion"
      get 'register'  # GETリクエストに対応
      post 'register' # POSTリクエストに対応
    end
  end


  #管理者アカウント
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  resources :admins, only: [:show]

  root to: 'top#index' #トップページ
  #特集
  get 'faq' => 'top#faq'
  get 'co' => 'top#co'
  get 'lp' => 'top#lp'
  get 'question' => 'top#question'

  get 'partner' => 'top#partner'


  get 'estimates/info' => 'estimates#info'

  get 'question' => 'top#question'
  get 'documents' => 'top#documents'
  get 'start' => 'top#start'
  get 'business' => 'top#business'
  get 'corporation' => 'top#corporation'  #会社概要
  get 'privacy' => 'top#privacy' #プライバシーポリシー

  resources :columns do
    collection do 
      post :import
    end
  end
  resources :questions

  resources :estimates do
    resources :client_comments, only: [:edit, :update]
    resources :progresses
    resources :payments, except: [:index]
    resources :comments  do
     member do
       post :update_status
     end
    end
    collection do
      post :confirm
      post :thanks
    end
    member do
      post :send_mail_cfsl
      post :send_mail
      get :select_sent
      get :confirm_point
      post 'old_email', to: 'estimates#old_email', as: 'old_email'
      post 'outside_email', to: 'estimates#outside_email', as: 'outside_email'
    end
  end
  get 'contract' => 'estimates#contract'
  get 'purchase' => 'estimates#purchase'
  get 'manufacturer' => 'estimates#manufacturer'
  post 'estimates/client_select', to: 'estimates#client_select', as: 'client_select_estimate'
  get 'estimates/:id/accept', to: 'estimates#accept', as: 'accept_estimate'
  get 'estimates/:id/decline', to: 'estimates#decline', as: 'decline_estimate'

  # メッセージ
  resources :messages, only: [:create] do
    collection do
      # メッセージルーム
      get :room, path: '/room/:uri_token'
    end
  end
  resources :payments, only: [:index]
  post 'update_payments', to: 'payments#bulk_update'
  resources :companies

  #get '*path', controller: 'application', action: 'render_404'
end
