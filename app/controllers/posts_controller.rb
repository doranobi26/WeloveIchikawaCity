class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] =　'The post was successful'
    redirect to post_path(@post.id)
    else
    redirect_to request.referer
  end


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
    if current_user != @post.user
    redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] =　'The post updated successfully'
    redirect_to post_path(@post.id)
  else
    render "edit"
  end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to post_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :caption)
  end
end
