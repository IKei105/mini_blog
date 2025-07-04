class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.references :follow_user, null: false, foreign_key: { to_table: :users }
      t.references :follower_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
