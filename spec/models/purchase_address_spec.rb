require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入情報の保存' do
    before do
      sleep 1 #読み込みスピードを遅くする
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)

    end

    context '正常系' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end

      it 'building_nameは空でも保存できる' do
        @purchase_address.building_name = nil
        expect(@purchase_address).to be_valid
      end
    end

    context '異常系' do
      it 'codeが空だと保存できない' do
        @purchase_address.code = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Code can't be blank")
      end

      it 'codeが半角のハイフンを含んだ正しい形式でないと保存できない' do
        @purchase_address.code = "1234567"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Code is invalid")
      end

      it 'prefectureを選択していないと保存できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'cityは空だと保存できない' do
        @purchase_address.city = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end 

      it 'addressが空だと保存できない' do
        @purchase_address.address = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phoneが空だと保存できない' do
        @purchase_address.phone = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone can't be blank")
      end

      it 'phonが9桁以下だと保存できない' do
        @purchase_address.phone = 123451234
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone is invalid")
      end

      it 'phoneが12桁以上保存できない' do
        @purchase_address.phone = 123451234512
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone is invalid")
      end

      it 'userの情報が無いと保存できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemの情報が無いと保存できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end  
end
