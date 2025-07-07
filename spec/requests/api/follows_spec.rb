require 'rails_helper'

RSpec.describe "Api::Follows", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    sign_in user
  end

  # describe "POST /api/follows" do
  #   it "フォローできる" do
  #     expect {
  #       post "/api/follows", params: { follow_user_id: other_user.id }
  #     }.to change(Follow, :count).by(1)

  #     expect(response).to have_http_status(:ok)
  #     expect(JSON.parse(response.body)["status"]).to eq("ok")
  #   end

  #   it "すでにフォローしてるときはレコードが増えない" do
  #     user.follow_users << other_user

  #     expect {
  #       post "/api/follows", params: { follow_user_id: other_user.id }
  #     }.not_to change(Follow, :count)

  #     expect(response).to have_http_status(:ok)
  #   end
  # end

  # describe "DELETE /api/follows/:id" do
  #   before { user.follow_users << other_user }

  #   it "フォロー解除できる" do
  #     expect {
  #       delete "/api/follows/#{other_user.id}"
  #     }.to change(Follow, :count).by(-1)

  #     expect(response).to have_http_status(:ok)
  #     expect(JSON.parse(response.body)["status"]).to eq("ok")
  #   end
  # end
end
