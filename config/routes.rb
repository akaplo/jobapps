Rails.application.routes.draw do
  root 'dashboard#main'

  resources :application_templates, only: [:new, :edit, :show]

  resources :application_records, only: [:create, :show] do
    member do
      post :review
    end
  end

  resource :dashboard, controller: :dashboard do
    collection do
      get  :main
      get  :staff
      get  :student
    end
  end

  resources :departments, except: [:index, :show]

  resources :interviews, only: :create do
    member do
      post :complete
      post :reschedule
    end
  end

  resources :positions, except: [:index, :show]
  
  resources :questions, only: [:create, :destroy, :update] do
    member do
      post :move
    end
  end

  resources :sessions, skip_current_user: true, only: [:new] do
    collection do
      case Rails.env
      when 'development'
        get  :dev_login
        post :dev_login
      when 'production', 'test'
        #something something Shibboleth?
      end
      delete :destroy
    end
  end

  resources :site_texts, only: [:edit, :update] do
    collection do
      get  :request_new
      post :request_new
    end
    member do
      post :edit#for previewing changes
    end
  end

  resources :users, except: [:index, :show]
  
end
