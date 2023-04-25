require 'rails_helper'

RSpec.describe 'User Controller' do
  describe '#create' do
    before do
      @user_params = {       
          email: 'user@example.com',
          password: '12345',
          password_confirmation: '12345'       
      }
    end

    it "creates a new user" do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers:, params: JSON.generate(@user_params)
   
      expect(response).to be_successful
      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data.keys).to eq([:data])
      expect(parsed_data[:data]).to be_a(Hash)
      expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
      expect(parsed_data[:data][:attributes]).to be_a(Hash)
      expect(parsed_data[:data][:attributes].keys).to eq([:email, :api_key])
    end
  end

  describe "sadpath" do
    it "can't create a user with mismatch password" do
      @user_params = {       
        email: 'user@example.com',
        password: '12345',
        password_confirmation: 'abcde'       
       }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers:, params: JSON.generate(@user_params)

      expect(response).to_not be_successful
      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data.keys).to eq([:errors])
      expect(parsed_data[:errors].first.keys).to eq([:status, :title, :detail])
    end

    it "can't create a user if no password confirmation" do
      @user_params = {       
        email: 'user@example.com',
        password: '12345',
        password_confirmation: ''       

       }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers:, params: JSON.generate(@user_params)

      expect(response).to_not be_successful

      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data.keys).to eq([:errors])
      expect(parsed_data[:errors].first.keys).to eq([:status, :title, :detail])
    end

    it "can't create user without an email" do
      @user_params = {       
        email: '',
        password: '12345',
        password_confirmation: '12345'       
       }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers:, params: JSON.generate(@user_params)

      expect(response).to_not be_successful

      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_data).to be_a(Hash)
      expect(parsed_data.keys).to eq([:errors])
      expect(parsed_data[:errors].first.keys).to eq([:status, :title, :detail])
    end
  end

  describe "log in" do
    it "can log in a user" do
      @user_params = {       
        email: 'user@example.com',
        password: '12345'
       }

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/sessions', headers:, params: JSON.generate(@user_params)

      expect(response).to be_successful
      parsed_data = JSON.parse(response.body, symbolize_names: true)
      binding.pry
    end
  end
end