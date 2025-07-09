class RenameFollowColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :follows, :follow_user_id, :followed_id
    rename_column :follows, :follower_user_id, :follower_id
  end
end
