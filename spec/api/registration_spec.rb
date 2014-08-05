require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'POST /api/register' do
    let(:attrs) do
      {
        registration:
        {
          user: Fabricate.attributes_for(:org_leader),
          organization: Fabricate.attributes_for(:organization),
          payment: Fabricate.attributes_for(:payment)
        }
      }
    end

    context 'with valid parameters', test: true do
      before(:example) { post! route: '/api/register', params: attrs }

      it 'should print success message' do
        # expect(JSON.parse(last_response.body)['message']).to eq('account registered')
        puts last_response.body
      end

      xit 'should set current user' do
        expect(JSON.parse(last_response.body)['current_user']['first_name']).to eq(User.last.first_name)
      end
    end
  end
end
