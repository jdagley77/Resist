class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  validates :comments, presence: true

end
