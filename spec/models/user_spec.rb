require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常系' do
      it 'ニックネーム、パスワード、確認用パスワード、苗字、名前、苗字（カナ）、名前（カナ）、生年月日があれば登録できる' do
        expect(@user).to be_valid
      end
    end 

    context '異常系' do
      it 'ニックネームが無いと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include ("Nickname can't be blank")
      end

      it 'メールアドレスが無いと登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '同じメールアドレスは登録できない' do
        @user.save
        second_user = User.new(nickname: 'sample', email: @user.email, password: 'b12345',password_confirmation: 'b12345', last_name: '矢部', first_name: '次郎', last_name_kana: 'ヤベ', first_name_kana: 'ジロウ', birthday: '2010-01-20')
        second_user.valid?
        expect(second_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'パスワードが無いと登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは６文字以上でないと登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'パスワードは半角英数字でないと登録できない' do
        @user.password = 'A１２３４５'
        @user.password_confirmation = 'A１２３４５' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワード(確認用)が空だと登録できない' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    
      it 'パスワードは確認用と同じで無いと登録出来ない' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
