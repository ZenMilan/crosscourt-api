class GitHubAuthenticator

  def initialize(current_user_id, response)
    @current_user = User.find(current_user_id)
    @access_token = response["access_token"]
    @scopes = response["scope"].split(',')
  end

  def authenticate!
    if @scopes && @scopes.include?('repo')
      @current_user.update_column('gh_access_token', @access_token)
      # retrun Struct?
      { message: "successfully authenticated with GitHub" }
    else
      # retrun Struct?
      { message: "Github authentication failed! Ensure that permissions allow access to repositories." }
    end
  end
end
