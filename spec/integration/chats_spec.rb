require 'swagger_helper'

describe 'Chat API' do
  let(:chat) { create(:chat) }
  path '/applications/{application_token}/chats' do
    get 'Retrieve application chats' do
      tags 'Chat'
      produces 'application/json'
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string
      parameter name: :application_token, in: :path
      
      response '200', 'Success' do
        let(:application_token) { chat.application.token }
        let(:page) { '1' }
        let(:per_page) { '5' }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{number}' do
    get 'Retrieve an application chat' do
      tags 'Chat'
      produces 'application/json'
      parameter name: :application_token, in: :path
      parameter name: :number, in: :path

      response '200', 'Success' do
        let(:application_token) { chat.application.token }
        let(:number) { chat.number }
        run_test!
      end

      response '404', 'Not Found' do
        let(:application_token) { 'invalid' }
        let(:number) { chat.number }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats' do
    post 'Create an application chat' do
      tags 'Chat'
      consumes 'multipart/form-data'
      parameter name: :application_token, in: :path
      parameter name: 'chat[name]', in: :formData

      before do 
        allow(Chats::CreateJob).to receive(:perform_later)
      end
      response '200', 'Success' do
        let(:application_token) { chat.application.token }
        let('chat[name]') { "chat name" }
        run_test!
      end

      response '422', 'Invalid' do
        let(:application_token) { chat.application.token }
        let('chat[name]') { nil }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{number}' do
    put 'Update an application chat' do
      tags 'Chat'
      consumes 'multipart/form-data'
      parameter name: :application_token, in: :path
      parameter name: :number, in: :path
      parameter name: 'chat[name]', in: :formData

      response '200', 'Success' do
        let('chat[name]') { "app name" }
        let(:application_token) { chat.application.token }
        let(:number) { chat.number }
        run_test!
      end

      response '422', 'Invalid' do
        let('chat[name]') { nil }
        let(:application_token) { chat.application.token }
        let(:number) { chat.number }
        run_test!
      end
    end
  end

  path '/applications/{application_token}/chats/{number}' do
    delete 'Delete an application chat' do
      tags 'Chat'
      consumes 'multipart/form-data'
      parameter name: :application_token, in: :path
      parameter name: :number, in: :path

      response '204', 'Success' do
        let(:application_token) { chat.application.token }
        let(:number) { chat.number }
        run_test!
      end

      response '404', 'Invalid' do
        let(:application_token) { 'invalid' }
        let(:number) { chat.number }
        run_test!
      end
    end
  end
end
