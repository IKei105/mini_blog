class AddNotNullConstraintToUsersIntroductionAndBlogUrl < ActiveRecord::Migration[8.0]
  def change
    # notnullを付与
    change_column_null :users, :introduction, false
    change_column_null :users, :blog_url, false
  end
end
