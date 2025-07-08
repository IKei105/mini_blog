class AddNotNullConstraintToUsersIntroductionAndBlogUrl < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :introduction, false
    change_column_null :users, :blog_url, false
  end
end
