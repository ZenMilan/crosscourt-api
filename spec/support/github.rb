shared_context "with mock github access token request" do

  # before(:all) do

  let(:stub) {
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
  }

  # end

  # after(:all) do
  #
  #   User.delete_all
  #
  # end

end
