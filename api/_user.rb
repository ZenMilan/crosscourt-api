module Crosscourt
  module User
    class API < Grape::API

      desc "Create a new user"
      params do
        requires :name, type: String, desc: "Your status."
      end
      post 'user' do
        { name: params[:name] }
      end

      get 'user' do
        { status: 'ok' }
      end

    end
  end
end
