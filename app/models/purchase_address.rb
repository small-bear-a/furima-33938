class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :code, :prefecture_id, :city, :address, :building_name, :phone ,:token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :code,          format:{with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city
    validates :address
    validates :phone,          format:{with: /\A\d{11}\z/ }
    validates :token
  end
  
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(code: code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone: phone, purchase_id: purchase.id)
  end
end