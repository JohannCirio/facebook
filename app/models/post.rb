class Post < ApplicationRecord
  validates :body, presence: true

  belongs_to :author, class_name: 'User'
end
