class Post < ApplicationRecord
  validates :body, presence: true
  validates :author_id, presence: true

  belongs_to :author, class_name: 'User'
  has_many :comments
end
