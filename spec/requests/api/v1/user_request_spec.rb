require 'rails_helper'

RSpec.describe 'User Controller' do
  describe '#create' do
    before do
      @user_params = {
        data: {
          email: 'user@example.com',
          password: '12345',
          password_confirmation: '12345'
        }
      }
    end

    it "creates a new user" do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers:, params: JSON.generate(@user_params)

      create_user = User.last
   
      expect(response).to be_successful
      expect(create_user.email).to eq('user@example.com')
      expect(create_user.password).to eq('12345')
      expect(create_user.password_confirmation).to eq('12345')
    end
  end
end