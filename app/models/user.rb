class User < ActiveRecord::Base
  has_secure_password
  has_many :favorites
  has_many :session_tokens
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  after_create :assign_token

  protected

  def assign_token
    SessionToken.create(user_id: id, token: SecureRandom.hex)
  end

end
