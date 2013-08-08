class Order < ActiveRecord::Base
  belongs_to :user,  inverse_of: :orders
  belongs_to :drink, inverse_of: :orders
end
