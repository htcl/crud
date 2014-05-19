class User < ActiveRecord::Base
  has_one :user_profile
  has_many :user_preferences
  has_and_belongs_to_many :roles

  attr_accessible :username
  attr_accessible :password
  attr_accessible :email

  validates :username, :presence => true

  def to_s
    username
  end
end
