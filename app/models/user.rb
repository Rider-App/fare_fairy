class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  before_validation :assign_token

  protected 

  def assign_token
    if token.nil?
      self.token = SecureRandom.hex
    end
  end

end
