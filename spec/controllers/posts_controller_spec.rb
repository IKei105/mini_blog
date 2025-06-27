require "rails_helper"

RSpec.describe PostsController, type: :controller do
  describe "POST #create" do
    context "投稿が成功" do
      it "投稿が保存される" do
        expect {
          post :create, params: { post: { content: "投稿テキスト" } }
        }.to change(Post, :count).by(1)
      end

      it "投稿成功後はルートパスにリダイレクトされる" do
        post :create, params: { post: { content: "投稿テキスト" } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "投稿が失敗" do
      it "空の内容では保存されない" do
        expect {
          post :create, params: { post: { content: "" } }
        }.not_to change(Post, :count)
      end

      it "140文字を超える内容では保存されない" do
        long_text = "あ" * 141
        expect {
          post :create, params: { post: { content: long_text } }
        }.not_to change(Post, :count)
      end

      it "失敗した場合はflashにエラーメッセージが入る" do
        post :create, params: { post: { content: "" } }
        expect(flash[:alert]).to eq "投稿に失敗しました"
      end

      it "失敗した場合はルートパスにリダイレクトされる" do
        post :create, params: { post: { content: "" } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
