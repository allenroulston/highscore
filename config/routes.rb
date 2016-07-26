Rails.application.routes.draw do

  # what may explain the step by step to solving LOGOUT problems
  # http://stackoverflow.com/questions/6946435/devise-why-doesnt-my-logout-link-work
  devise_for :users do
    get 'logout' => 'devise/sessions#destroy' # very important -ALLEN ROULSTON
  end
  
  resources :high_scores do
    collection do
      get 'welcome'
    end
  end
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "high_scores#welcome"
  
end
