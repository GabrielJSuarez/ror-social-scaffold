class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200,
                                                too_long: 'Only 200 characters per comments.' }

  belongs_to :user
  belongs_to :post
end
