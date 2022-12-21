Rails.application.routes.draw do
  devise_for :users
  root 'users#splash'
  
  resources :users
  resources :groups, :path => "categories" do 
    resources :expenses, :path => "transactions"
  end
end
