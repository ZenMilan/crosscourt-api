require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Registration#register!' do
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

    context 'with valid parameters' do
      it 'should create a user' do
        expect { register! }.to change { User.count }.by 1
      end

      it 'should create an organization' do
        expect { register! }.to change { Organization.count }.by 1
      end

      it 'should create a payment' do
        expect { register! }.to change { Payment.count }.by 1
      end

      it 'should return a user' do
        expect(register!).to include(:user)
      end

      it 'should set user as organization leader' do
        register!

        expect(User.last.type).to eq 'OrganizationLeader'
      end

      it 'should create user / organization association' do
        register!

        expect(User.last.organizations).to include(Organization.last)
      end

      it 'should create organization / payment association' do
        register!

        expect(Organization.last.payment).to eq Payment.last
      end
    end

    context 'with invalid parameters' do
      it 'fails when first name is blank' do
        expect do
          register! params: attrs[:registration].merge!(user: Fabricate.attributes_for(:user, first_name: ''))
        end.to raise_error RegistrationErrors::ValidationError, /can't be blank/
      end

      it 'fails when last name and email are blank' do
        expect do
          register! params: attrs[:registration].merge!(user: Fabricate.attributes_for(:user, last_name: '', email: ''))
        end.to raise_error RegistrationErrors::ValidationError, /can't be blank/
      end

      it 'fails when organization name is blank' do
        expect do
          register! params: attrs[:registration].merge!(organization: Fabricate.attributes_for(:organization, name: ''))
        end.to raise_error RegistrationErrors::ValidationError, /can't be blank/
      end
    end

    context 'with existing credentials' do

      before(:example) do
        register! params: attrs[:registration].merge!(user: Fabricate.attributes_for(:user, email: 'pruett.kevin@gmail.com'))
      end

      it 'fails to create new account' do
        expect do
          register! params: attrs[:registration].merge!(organization: Fabricate.attributes_for(:user, email: 'pruett.kevin@gmail.com'))
        end.to raise_error RegistrationErrors::ValidationError
      end
    end
  end
end
