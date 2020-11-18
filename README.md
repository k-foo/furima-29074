# README

<!-- This README would normally document whatever steps are necessary to get the
application up and running.
Things you may want to cover:
* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ... -->


# アプリ名
furima-29074
https://furima-29074.herokuapp.com/

# 説明
ログイン後、商品の出品（編集）・購入をすることができます。

<!-- # 使い方 -->
<!-- Coming Soon -->

# ER図
[【ER図】furima-29074.pdf](https://github.com/erika618/furima-29074/files/5559884/ER.furima-29074.pdf)

# テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| :--------          | :-----   | :----------               |
| nickname           | string   | null: false, unique: true |
| email              | string   | null: false, unique: true |
| password           | string   | null: false, unique: true |
| password_confirm   | string   | null: false, unique: true |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |
| last_name_kana     | string   | null: false               |
| first_name_kana    | string   | null: false               |
| birthday           | datetime | null: false               |


### Association

- has_many :items
- has_many :buys
- has_many :comments

<br>

## items テーブル

| Column            | Type       | Options                        |
| :------           | :------    | :-----------                   |
| user              | references | null: false, foreign_key: true |
| buy               | references | null: false, foreign_key: true |
| deleted_at        | datetime   |                                |
| image             | integer    | null: false                    |
| item_name         | string     | null: false                    |
| description       | text       | null: false                    |
| category_id       | integer    | null: false                    |
| item_status_id    | integer    | null: false                    |
| shipping_costs_id | integer    | null: false                    |
| delivery_area_id  | integer    | null: false                    |
| shipping_date_id  | integer    | null: false                    |
| price             | integer    | null: false                    |
| commission        | integer    | null: false                    |
| profit            | integer    | null: false                    |

### Association

- belongs_to  :user
- has_one     :item
- has_one     :buy

<br>

##  buysテーブル

| Column        | Type       | Options                        |
| :------       | :----------| :------------------------------|
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |
| ordered_at    | datetime   | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :shipping_address

<br>

## shipping_addressesテーブル

| Column        | Type       | Options                        |
| :-------      | :--------- | :------------------------------|
| buy           | references | null: false, foreign_key: true |
| postcode      | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone_number  | integer    | null: false, unique: true      |

### Association

- belongs_to :buy

<br>

## commentsテーブル

| Column  | Type       | Options                        |
| :-------| :----------| :------------------------------|
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |
| text    | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :item

