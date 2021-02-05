class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200,
                                                too_long: 'Only 1000 characters per post ' }

  belongs_to :user
  belongs_to :post
end
