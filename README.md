# README
# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| -------------------| ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| password           | string  | null: false               |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: fales               |
|birthday            | date    | null: fales               |

### Association
- has_many :items
- has_many :purchases



## items テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | ------------------------------ |
| title            | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| state_id         | integer    | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_day_id  | integer    | null: false                    |
| price            | integer    |                                |
| user             | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :purchase



## purchase テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreige_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address



## address テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| code          | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone         | string     | null: false                    |
|item           | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase
