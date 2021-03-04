class TweetsController < ApplicationController
  # Viewへ渡す際には、インスタンス変数をつけるが、Viewへ渡さないならインスタンス変数は不要
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index #userのTweetsテーブル内のTweetをビューへ渡す
    @tweets = Tweet.includes(:user).order("created_at DESC") 
    #includesで一度にuserモデルから情報を取得する。orderメソッドで並び替え
  end

  def new #新規投稿のため空のTweetをビューへ渡す→Createへ
    @tweet = Tweet.new
  end

  def create #newアクションから受け取ったTweetをフィルタリングしてテーブルへ保存する
    Tweet.create(tweet_params)
  end

  def destroy #選択されたTweetをテーブルから消す
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit #編集するため選択されたTweetをビューへ渡す→Updateへ
    # before_actionでset_tweet実施
  end

  def update #destroyと同様にtweet変数に選択したTweetを入れてテーブルの更新を行う
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show #詳細表示したいTweetをビューへ渡す→もらったTweetをビューで表示する
    # before_actionでset_tweet実施
    @comment = Comment.new 
     #commentを子であるcommentsコントローラーに送るためインスタンスを作成する
    @comments = @tweet.comments.includes(:user)
     #ツイートに関するコメントを取得し、表示するためにビューへ渡す
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params #new・editでビューから渡されるパラメーターにフィルターをかける
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
