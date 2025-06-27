class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :content, limit: 140, null: false

      t.timestamps
    end
  end
end
