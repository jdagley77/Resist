class User < ApplicationRecord
  has_many :comments
  has_many :payments
  has_many :issues


  
end
