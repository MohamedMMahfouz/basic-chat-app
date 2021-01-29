require 'swagger_helper'

describe 'Applciation API' do
  path '/applications' do
    get 'Retrieve all applications' do
      tags 'Application'
      produces 'application/json'
      parameter name: :page, in: :query, type: :string
      parameter name: :per_page, in: :query, type: :string

      response '200', 'Success' do
        let(:page) { '1' }
        let(:per_page) { '5' }
        run_test!
      end
    end
  end

  path '/applications/{token}' do
    get 'Retrieve an applications' do
      tags 'Application'
      produces 'application/json'
      parameter name: :token, in: :path

      let(:application) { create(:application) }
      response '200', 'Success' do
        let(:token) { application.token }
        run_test!
      end

      response '404', 'Not Found' do
        let(:token) { 'invalid' }
        run_test!
      end
    end
  end

  path '/applications' do
    post 'Create an application' do
      tags 'Application'
      consumes 'multipart/form-data'
      parameter name: 'application[name]', in: :formData

      response '201', 'Success' do
        let('application[name]') { "app name" }
        run_test!
      end

      response '422', 'Invalid' do
        let('application[name]') { nil }
        run_test!
      end
    end
  end

  path '/applications/{token}' do
    put 'Update an application' do
      tags 'Application'
      consumes 'multipart/form-data'
      parameter name: :token, in: :path
      parameter name: 'application[name]', in: :formData

      let(:application) { create(:application) }
      response '200', 'Success' do
        let('application[name]') { "app name" }
        let(:token) { application.token }
        run_test!
      end

      response '422', 'Invalid' do
        let(:token) { application.token }
        let('application[name]') { nil }
        run_test!
      end
    end
  end

  path '/applications/{token}' do
    delete 'Delete an application' do
      tags 'Application'
      consumes 'multipart/form-data'
      parameter name: :token, in: :path

      let(:application) { create(:application) }
      response '204', 'Success' do
        let(:token) { application.token }
        run_test!
      end

      response '404', 'Invalid' do
        let(:token) { 'invalid' }
        run_test!
      end
    end
  end
end
