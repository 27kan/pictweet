class CommentsController < ApplicationController
  def create
    Comment.create(comment_params)
    redirect_to "/tweets/#{comment.tweet.id}"
    #コメントを保存したらコメント投稿完了画面ではなく元のツイートにリダイレクトで返す
    #redirect_to の後にPrefixを指定する
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end

end
