Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :applications, param: :token do 
    resources :chats, param: :number do 
      resources :messages, param: :number
    end
  end
end
