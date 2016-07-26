Rails.application.routes.draw do
  resources :high_scores
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "high_scores#index"
  
  devise_for :users do
    get 'logout' => 'devise/sessions#destroy' # very important -ALLEN ROULSTON
  end

end
