class Issue < ApplicationRecord
  belongs_to :user
  has_many   :payments

  validates :title, presence: true
  validates :description, presence: true

# method for calculating the total amt donated
	# def amount
	# 	payments.each do |payment|
	# 		payment.each do |record|
	# 			record.reduce(:+)
	# 		end
	# 	end
	# end

end
