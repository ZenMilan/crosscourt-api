require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Authentication' do
    describe 'POST /api/login' do
      include_context "create new user"

      context 'with correct credentials' do
        it 'logs in user' do
          login_user email: 'pruett.kevin@gmail.com', password: 'password123'
          expect(last_response.body).to eq({ status: 'ok' }.to_json)
        end
      end

      context 'with incorrect credentials' do

        context 'with correct email but incorrect password' do
          it 'reports invalid credentials' do
            login_user email: 'pruett.kevin@gmail.com', password: 'password1234'
            expect(last_response.body).to eq({ error: 'Invalid email or password' }.to_json)
          end
        end

        context 'with incorrect email and correct password' do
          it 'reports invalid credentials' do
            login_user email: 'pruettt.kevin@gmail.com', password: 'password123'
            expect(last_response.body).to eq({ error: 'Invalid email or password' }.to_json)
          end
        end

      end
    end

    describe 'DELETE /api/logout' do
      include_context "create new user"

      context 'when logged in' do
        it 'successfully logs me out' do
          login_user email: 'pruett.kevin@gmail.com', password: 'password123'
          delete  '/api/logout'
          expect(last_response.body).to eq({ status: 'ok' }.to_json)
        end
      end

      context 'when not logged in' do
        it 'should output an error' do
          delete '/api/logout'
          expect(last_response.body).to eq({ error: 'Unable to log out' }.to_json)
        end
      end

    end
  end
end
