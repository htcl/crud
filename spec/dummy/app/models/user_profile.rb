class UserProfile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :forename
  attr_accessible :surname
  attr_accessible :user, :user_id

  validates :user, :presence => true

  def to_s
    "#{forename} #{surname}"
  end
end
