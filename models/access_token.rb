class AccessToken < ActiveRecord::Base
  validates :token, uniqueness: true, presence: true

  def self.generate_token
    create! token: new_token
  end

  protected

  def self.new_token
    Digest::SHA1.hexdigest([Time.now, rand].join)[0..5]
  end

end
