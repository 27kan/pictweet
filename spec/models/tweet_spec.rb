require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe 'ツイートの保存' do
    context 'ツイートの投稿ができる場合' do
      it '画像とテキストがあれば投稿できる' do
        expect(@tweet).to be_valid
      end
      it 'テキストがあれば投稿できる' do
        @tweet.image = ''
        expect(@tweet).to be_valid
      end
    end

    context 'ツイートの投稿ができない場合' do
      it 'テキストが空では投稿できない' do
        @tweet.text = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "Text can't be blank"
      end
      it 'Userが紐づいていなければ投稿できない' do
        @tweet.user = nil # .userでuserモデルからの情報を見れる
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "User must exist"
      end
    end
  end
end
