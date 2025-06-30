class AddProfileToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :introduction, :string, limit: 200
    add_column :users, :blog_url, :string
  end
end
