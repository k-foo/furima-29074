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

# ER 図
<img width="1254" alt="【ER図】furima-29074" src="https://user-images.githubusercontent.com/68714247/102007762-2799ff00-3d6f-11eb-9e11-58e7b2c9d1d9.png">

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| :----------------- | :----- | :------------------------ |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false, unique: true |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders
- has_many :comments

<br>

## items テーブル

| Column           | Type       | Options                        |
| :--------------- | :--------- | :----------------------------- |
| user             | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| item_status_id   | integer    | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_date_id | integer    | null: false                    |
| price            | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :order
- has_many :comments

<br>

## orders テーブル

| Column | Type       | Options                        |
| :----- | :--------- | :----------------------------- |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :payment

<br>

## payments テーブル

| Column        | Type       | Options                        |
| :------------ | :--------- | :----------------------------- |
| orders        | references | null: false, foreign_key: true |
| postcode      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to :order

<br>

## comments テーブル

| Column | Type       | Options                        |
| :----- | :--------- | :----------------------------- |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
| text   | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :item
