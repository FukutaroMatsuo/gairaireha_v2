# アプリケーションの概要
病院のリハビリ部門に特化した、患者情報、収益管理サービス。  
URL: [https://www.rehakanri.tk](https://www.rehakanri.tk)  
現在、ログイン制限しています。[Twitter](https://twitter.com/fukusan0901)にDM頂けると、ID、PassWordを教えることが可能です。  

# 技術ポイント  
- materalize css を使用した、レスポンシブ対応のシンプルなデザイン
- Chartkick.js を使用してのわかりやすいグラフ描画
- 新規登録不可で、管理者が登録した場合のみログイン可能(二段階認証導入予定)
- ActiveRecord メソッドや生の SQL を使って、収益等、あらゆる数字を算出
- 日報一覧ページでは、当日の全患者情報を閲覧でき、CSV 形式で出力することができる
- RSpecを用いたテスト（まだ途中です）

# 機能
- 患者情報登録
- 毎日の日報の入力
- 日報情報から、日〜年単位での収益の数字をグラフ描画
- 当月来院のない患者や、来院回数の少ない患者の情報がひと目でわかる
- 患者ごとの目標の管理（達成率も算出）
- ログイン
- ログイン情報の維持
- モデルのバリデーション
- CSV出力

# 環境
- 開発環境
  - Docker（docker-compose）
  - Ruby on Rails
  - Nginx
  - PostgreSQL
- 本番環境
  - AWS: ECS(EC2),ECR,ELB,RDS（PostgreSQL）
  - Ruby on Rails
  - Nginx