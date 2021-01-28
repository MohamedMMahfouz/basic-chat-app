Rails.application.routes.draw do
  resources :applications, param: :token do 
    resources :chats, param: :chat_number do 
      resources :messages, param: :message_number
    end
  end
end
