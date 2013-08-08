class Drink < ActiveRecord::Base
  validates_presence_of :name

  LARGE = "Large"
  REGULAR = "Regular"
  SMALL = "Small"

  SIZE = [LARGE, REGULAR, SMALL]
end
