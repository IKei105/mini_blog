require "rails_helper"

# RSpec.describe PostsController, type: :controller do
#   include Devise::Test::ControllerHelpers

#   let(:user) { create(:user) }
#   let(:valid_userid) { user.userid }
#   let(:valid_content) { "投稿テキスト" }
#   let(:long_content) { "あ" * 141 }

#   before do
#     sign_in user, scope: :user
#   end

#   describe "POST #create" do
#     context "投稿成功" do
#       it "投稿が保存される" do
#         expect {
#           post :create, params: { post: { content: valid_content } }
#         }.to change(Post, :count).by(1)
#       end

#       it "投稿成功後はルートパスにリダイレクトされる" do
#         post :create, params: { post: { content: valid_content } }
#         expect(response).to redirect_to(root_path)
#       end
#     end

#     context "投稿失敗" do
#       it "空の内容では保存されない" do
#         expect {
#           post :create, params: { post: { content: "" } }
#         }.not_to change(Post, :count)
#       end

#       it "140文字を超える内容では保存されない" do
#         expect {
#           post :create, params: { post: { content: long_content } }
#         }.not_to change(Post, :count)
#       end
#     end

#     context "useridがセッションにない場合" do
#       before do
#         sign_out user
#       end

#       it "投稿は保存されない" do
#         expect {
#           post :create, params: { post: { content: valid_content } }
#         }.not_to change(Post, :count)
#       end
#     end
#   end
# end
