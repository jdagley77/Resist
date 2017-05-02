class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  validates :amt, presence: true

end
