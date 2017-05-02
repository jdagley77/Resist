class Issue < ApplicationRecord
  belongs_to :user
  has_many   :payments

  validates :title, presence: true
  validates :description, presence: true

end
