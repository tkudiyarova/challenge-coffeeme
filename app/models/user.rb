class User < ActiveRecord::Base
  has_many :orders, inverse_of: :user

  validates_presence_of :name, :email
end
