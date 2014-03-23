require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Github Authentication' do

    describe 'GET /api/github/callback' do
      include_context "with logged in user"

      context 'with valid response from Github' do

        let!(:stub) do
          Faraday.new(url: 'https://github.com') do |faraday|
            faraday.adapter :test do |stub|
              stub.post('/login/oauth/access_token') {
                [ 200, { 'Accept' => 'application/json' },
                  {
                    "access_token"=>"9ac430acbe98cc857e3f9a6d0136670a332e41f1",
                    "token_type"=>"bearer",
                    "scope"=>"repo"
                  }.to_json
                ]
              }
            end
          end
        end

        let!(:response) { JSON.parse(stub.post('https://github.com/login/oauth/access_token').body)
        }

        describe GitHubAuthenticator do

          subject { GitHubAuthenticator.new(User.last.id, response) }

          it { is_expected.to respond_to(:authenticate!) }

          it "should have a valid access token" do
            expect(subject.instance_variable_get(:@access_token)).to eq "9ac430acbe98cc857e3f9a6d0136670a332e41f1"
          end

          it "should have a permission of repo" do
            expect(subject.instance_variable_get(:@scopes)).to include("repo")
          end

          it "#authenticate!" do
            expect(subject.authenticate!).to eq({ message: "successfully authenticated with GitHub" })
          end

        end

      end

    end

  end

end
