require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Github Authentication' do

    describe 'GET /api/github/callback' do
      include_context "with logged in user"

      def stub_request(token, scope)
        Faraday.new(url: 'https://github.com') do |faraday|
          faraday.adapter :test do |stub|
            stub.post('/login/oauth/access_token') {
              [ 200, { 'Accept' => 'application/json' },
                {
                  "access_token"=>token,
                  "token_type"=>"bearer",
                  "scope"=>scope
                }.to_json
              ]
            }
          end
        end
      end

      context 'with valid response from Github' do

        let!(:stub) { stub_request("9ac430acbe98cc857e3f9a6d0136670a332e41f1", "repo") }

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

          it "sets access token attribute on current user" do
            subject.authenticate!
            expect(User.last.gh_access_token).to eq "9ac430acbe98cc857e3f9a6d0136670a332e41f1"
          end

        end
      end

      context 'with invalid response from Github' do

        let!(:stub) { stub_request("9ac430acbe98cc857e3f9a6d0136670a332e41f1", "nothing") }

        let!(:response) { JSON.parse(stub.post('https://github.com/login/oauth/access_token').body)
        }

        describe GitHubAuthenticator do

          subject { GitHubAuthenticator.new(User.last.id, response) }

          it "#authenticate!" do
            expect(subject.authenticate!).to eq({ error: "Github authentication failed! Ensure that permissions allow access to repositories." })
          end

          it "fails to set access token attribute on current user" do
            subject.authenticate!
            expect(User.last.gh_access_token).to be_nil
          end

        end
      end

    end
  end
end
