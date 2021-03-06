require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user) 
    #各exampleでインスタンス作成を行うためあらかじめインスタンス変数に格納しておく
  end
  
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      @user.nickname = '' #nicknameが空のテストなのでnicknameに''を代入
      @user.valid? #valid?はvalidateを実行し、空がなければtrueを返す
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
      #expect（検証結果）.to include(想定する結果) で検証結果が想定通りか判断する
    end
    it 'emailが空では登録できない' do
      @user.email = '' 
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
      # includeをeqにする場合、配列として指定すればOK。
      # eq(["Email can't be blank"])とすれば、配列同士で照合可能
    end
  end
end

# pending "add some examples to (or delete) #{__FILE__}"