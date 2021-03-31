class Comment < ApplicationRecord
  validates :content, presence: true
  validates :author_id, presence: true
  validates :post_id, presence: true

  belongs_to :post
  belongs_to :author, class_name: 'User'

  has_many :likes, as: :likeable

  after_save :update_post_last_comment_at

  private
  
  def update_post_last_comment_at
    self.post.touch(:last_comment_at) if self.post
  end
  
end
