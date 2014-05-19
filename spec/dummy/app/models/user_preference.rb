class UserPreference < ActiveRecord::Base
  belongs_to :user

  attr_accessible :key, :value
  attr_accessible :user, :user_id

  validates :user, :presence => true

  #---------------------------------------------------------------------------

  def to_s
    "#{key}=#{value}"
  end
end
