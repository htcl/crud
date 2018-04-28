class Colour < ApplicationRecord
  #attr_accessible :name, :colour_code

  def to_s
    name
  end
end
