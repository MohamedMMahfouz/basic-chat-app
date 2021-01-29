require 'swagger_helper'

describe 'Messages API' do
  let(:chat) { create(:chat) }
  let(:message) { create(:message) }
  path '/applications/{application_token}/chats/{chat_number}/messages' do
    get 'Retrieve application chat messages' do
      tags 'Message'
      produces 'application/json'
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string
      parameter name: :application_token, in: :path
      parameter name: :chat_number, in: :path
      
      response '200', 'Success' do
        let(:application_token) { chat.application.token }
        let(:chat_number) { chat.number }
        let(:page) { '1' }
        let(:per_page) { '5' }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{chat_number}/messages/{number}' do
    get 'Retrieve an application chat message' do
      tags 'Message'
      produces 'application/json'
      parameter name: :application_token, in: :path
      parameter name: :chat_number, in: :path
      parameter name: :number, in: :path

      response '200', 'Success' do
        let(:application_token) { message.chat.application.token }
        let(:chat_number) { message.chat.number }
        let(:number) { message.number }
        run_test!
      end

      response '404', 'Not Found' do
        let(:application_token) { 'invalid' }
        let(:chat_number) { message.chat.number }
        let(:number) { chat.number }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{chat_number}/messages' do
    post 'Create an application chat message' do
      tags 'Message'
      consumes 'multipart/form-data'
      parameter name: :application_token, in: :path
      parameter name: :chat_number, in: :path
      parameter name: 'message[content]', in: :formData

      before do 
        allow(Messages::CreateJob).to receive(:perform_later)
      end
      response '200', 'Success' do
        let(:application_token) { message.chat.application.token }
        let(:chat_number) { message.chat.number }
        let('message[content]') { 'content' }
        run_test!
      end

      response '422', 'Invalid' do
        let(:application_token) { message.chat.application.token }
        let(:chat_number) { message.chat.number }
        let('message[content]') { nil }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{chat_number}/messages/{number}' do
    put 'Update an application chat' do
      tags 'Message'
      consumes 'multipart/form-data'
      parameter name: :application_token, in: :path
      parameter name: :chat_number, in: :path
      parameter name: :number, in: :path
      parameter name: 'message[content]', in: :formData

      response '200', 'Success' do
        let('message[content]') { "app name" }
        let(:application_token) { message.chat.application.token }
        let(:chat_number) { message.chat.number }
        let(:number) { message.number }
        run_test!
      end

      response '422', 'Invalid' do
        let('message[content]') { nil }
        let(:application_token) { message.chat.application.token }
        let(:chat_number) { message.chat.number }
        let(:number) { message.number }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{chat_number}/messages/{number}' do
    delete 'Delete an application chat' do
      tags 'Message'
      consumes 'multipart/form-data'
      parameter name: :application_token, in: :path
      parameter name: :chat_number, in: :path
      parameter name: :number, in: :path

      response '204', 'Success' do
        let(:application_token) { message.chat.application.token }
        let(:chat_number) { message.chat.number }
        let(:number) { message.number }
        run_test!
      end

      response '404', 'Invalid' do
        let(:application_token) { message.chat.application.token }
        let(:chat_number) { message.chat.number }
        let(:number) { 'invalid' }
        run_test!
      end
    end
  end
end
