Rails.application.routes.draw do
  namespace 'api' do
  	resources :user
    resources :restaurant do
      resources :menu
    end
  end
  post 'authenticate', to: 'authentication#authenticate'
end
