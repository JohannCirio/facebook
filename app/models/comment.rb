class Comment < ApplicationRecord
  validates :content, presence: true
  validates :author_id, presence: true
  validates :post_id, presence: true

  belongs_to :post
  belongs_to :author, class_name: 'User'
end
