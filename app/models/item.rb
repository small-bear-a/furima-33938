class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :price, inclusion: { in: 300..9_999_999 }, numericality: { only_integer: true }
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :state_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_day_id
  end
end
