class GitHubAuthenticator
  def initialize(current_user_id, response)
    @current_user = User.find(current_user_id)
    @access_token = response['access_token']
    @scopes = response['scope'].split(',')
  end

  def authenticate!
    return { fail: 'authentication_failed' } unless @scopes && @scopes.include?('repo')

    @current_user.update_column('gh_access_token', @access_token)
    { success: 'authentication_successful' }
  end
end
