class CommentsController < ApplicationController
  def create
  	@post = Post.find(params[:post_id])
  	@comment = post.comments.new(comment_params)
  	@comment.user_id = current_user.id
  	@comment.save
  	redirect_to request.referer
  end

  def destroy
  	@comment = Comment.find(params[:id])
  	@commnet.destroy
  	redirect_to request.referer
  end

  def commnet_params
  	params.require(:comment).permit(:commnet, :user_id)
  end
end
