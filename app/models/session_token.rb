class SessionToken < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :token, presence: true  


end
