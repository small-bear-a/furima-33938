# README
# テーブル設計

## users テーブル

| Column          | Type    | Options     |
| ----------------| ------- | ----------- |
| nickname        | string  | null: false |
| email           | string  | null: false |
| password        | string  | null: false |
| last_name       | string  | null: false |
| first_name      | string  | null: false |
| last_name_kana  | string  | null: false |
| first_name_kana | string  | null: fales |
|bersday          | integer | null: fales |

### Association
- has_many :items
- has_one :purchases



## items テーブル

| Column     | Type       | Options                        |
| -----------| ---------- | ------------------------------ |
| title      | string     | null: false                    |
| catch_copy | text       | null: false                    |
| concept    | text       | null: false                    |
| user_id    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase



## purchase テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreige_key: true |
| item_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address



## address テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| code          | integer    | null: false                    |
| prefecture    | string     | null: false, foreign_key: true |
| city          | string     | null: false, foreign_key: true |
| address       | string     | null: false                    |
| building_name | string     | null: false                    |
| phone         | integer    | null: false                    |
|item_id        | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase
