class Favorite < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :address, presence: true

end
