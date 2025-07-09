class AddUniqueIndexToFollows < ActiveRecord::Migration[8.0]
  def change
    add_index :follows, [:followed_id, :follower_id], unique: true
  end
end
