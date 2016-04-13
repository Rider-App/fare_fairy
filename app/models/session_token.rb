class SessionToken < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :token, presence: true

  def self.cleanup_old_tokens
    SessionToken.where("created_at < ?", 1.week.ago).destroy_all
  end


end
