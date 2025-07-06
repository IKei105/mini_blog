class Api::FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow_user = User.find(params[:follow_user_id]) # bodyから取得

    # フォローしていないならフォローする(レコードを追加する)
    # current_user.follow_users ログイン中のユーザーを取得
    # include?(follow_user) 相手をフォローしているかチェックする
    # << follow_user 中間テーブル(follow)に追加
    current_user.follow_users << follow_user unless current_user.follow_users.include?(follow_user)
    render json: { status: 'ok' }
  # 例外が発生した場合はエラーレスポンスを返す
  rescue => e
    render json: { status: 'error', message: 'エラーが発生しました' }, status: :unprocessable_entity #422
  end

  def destroy
    follow_user = User.find(params[:id])

    # フォローしているユーザーから対象を削除
    current_user.follow_users.destroy(follow_user)
    render json: { status: 'ok' }
  # 例外が発生した場合はエラーレスポンスを返す
  rescue => e
    render json: { status: 'error', message: 'エラーが発生しました' }, status: :unprocessable_entity #422
  end
end
