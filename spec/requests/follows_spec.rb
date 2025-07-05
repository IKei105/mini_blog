# require 'rails_helper'

# RSpec.describe "Follows", type: :request do
#   let(:user) { create(:user) }
#   let(:other_user) { create(:user) }

#   before do
#     sign_in user
#   end

#   describe "POST /follows" do
#     it "他人をフォローするとレコードが1つ増える" do
#       expect {
#         post follows_path, params: { follow_user_id: other_user.id }
#       }.to change(Follow, :count).by(1)
#     end

#     it "自分自身はフォローできない" do
#       expect {
#         post follows_path, params: { follow_user_id: user.id }
#       }.not_to change(Follow, :count)
#     end
#   end

#   describe "DELETE /follows/:id" do
#     before do
#       user.follows.create(follow_user_id: other_user.id)
#     end

#     it "フォロー解除するとレコードが1つ減る" do
#       expect {
#         delete follow_path(other_user.id)
#       }.to change(Follow, :count).by(-1)
#     end

#     it "存在しないフォローIDを削除してもエラーにならない" do
#       expect {
#         delete follow_path(999999)
#       }.not_to change(Follow, :count)
#       expect(response).to redirect_to(root_path)
#     end
#   end
# end
