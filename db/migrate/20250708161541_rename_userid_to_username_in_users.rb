class RenameUseridToUsernameInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :userid, :username
  end
end
