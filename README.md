# ミニブログ

課題として作成したミニブログアプリです。

---

## 導入方法

以下のDocker対応Railsアプリをクローンしてください。  
ルートディレクトリでこのリポジトリを `src` フォルダとして配置してください。

git clone https://github.com/IKei105/rails_container.git src

次に、Dockerコンテナをビルドして起動します：

docker-compose build

docker-compose up -d

データベースを作成・マイグレーションし、初期データ（テストユーザーと投稿）を投入します：

docker-compose exec app rails db:create db:migrate db:seed

---

## アクセス

http://localhost:3000 にアクセスしてください。

---

## ログイン（テストユーザー）

以下のアカウントでログインできます：

- ユーザーID: testOne
  パスワード: password123

- ユーザーID: testTwo
  パスワード: password123

- ユーザーID: testThree 
  パスワード: password123

- ユーザーID: testFour 
  パスワード: password123

- ユーザーID: testFive
  パスワード: password123

トップページの「ログイン」ボタンを押すと、ログインページへ遷移します。

---

## 機能一覧

- ユーザー登録 / ログイン / ログアウト（Devise使用）
- 投稿作成・一覧表示
- 投稿タイムライン（全体 / フォロー中）
- フォロー / フォロー解除
- 各種バリデーション、RSpecによるテスト

---

## 使用技術

- Ruby on Rails 8.0
- PostgreSQL
- Docker / Docker Compose
- RSpec / FactoryBot
- Haml / SCSS
