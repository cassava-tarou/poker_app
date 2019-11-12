Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'hands#index'
  
  get 'hands' => 'hands#index'
  get 'hands/judge' => 'hands#judge'
  post 'hands/judge' => 'hands#judge'
end
