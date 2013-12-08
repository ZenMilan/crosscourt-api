class User < ActiveRecord::Base

  def self.authenticate(username, password)
    user = self.find_by_username(username)
    user if user && ::Digest::MD5.hexdigest(::Digest::MD5.hexdigest(password)) == user.password
  end

end
