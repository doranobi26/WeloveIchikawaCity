class CommentsController < ApplicationController
  def create
  	post = Post.find(params[:post_id])
  	comment = post.comments.new(comment_params)
  	comment.user_id = current_user.id
  	comment.save
  	redirect_to request.referer
    #binding.pry
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  	redirect_to request.referer
  end

  def comment_params
  	params.require(:comment).permit(:comment)
  end
end
