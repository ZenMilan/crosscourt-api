class GitHubAuthenticator

  def initialize(id, access_token: nil, scopes: nil)
    @current_user = id
    @access_token = access_token
    @scopes = scopes

    authenticate!
  end

  def authenticate!
    if @scopes && @scopes.include?('repo')
      User.find(@current_user).update_column(gh_access_token: @access_token)
      # retrun Struct?
      { message: "successfully authenticated with GitHub" }
    else
      # retrun Struct?
      { message: "Github authentication failed! Ensure that permissions allow access to repositories." }
    end
  end
end
