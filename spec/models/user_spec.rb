require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user) 
    #各exampleでインスタンス作成を行うためあらかじめインスタンス変数に格納しておく
  end

  # describe 大グループ、 context 中グループ、 it テストパターン
  
  describe 'ユーザー新規登録' do
    context '新規登録できるとき（正常系）' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが6文字以下であれば登録できる' do
        @user.nickname = 'aaaaaa'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない（異常系）' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        # メッセージがcan't be blankじゃないよ！
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'nicknameが7文字以上では登録できない' do
        @user.nickname = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname is too long (maximum is 6 characters)"
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save # 一度ユーザーをsaveして
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email #既に登録したユーザーからemailをもらってくる
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345' #passwordはインスタンス生成後に代入されてるから再代入が必要
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
    end
  end
end

# このシートのテストコマンド
# bundle exec rspec spec/models/user_spec.rb

# pending "add some examples to (or delete) #{__FILE__}"


# 異常系テストの練習

# it 'nicknameが空では登録できない' do
#   @user.nickname = '' #nicknameが空のテストなのでnicknameに''を代入
#   @user.valid? #valid?はvalidateを実行し、空がなければtrueを返す
#   expect(@user.errors.full_messages).to include "Nickname can't be blank"
#   #expect（検証結果）.to include(想定する結果) で検証結果が想定通りか判断する
# end
# it 'emailが空では登録できない' do
#   @user.email = '' 
#   @user.valid?
#   expect(@user.errors.full_messages).to include "Email can't be blank"
#   # includeをeqにする場合、配列として指定すればOK。
#   # eq(["Email can't be blank"])とすれば、配列同士で照合可能
# end