class AddLastCommentAtToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :last_comment_at, :datetime
  end
end
