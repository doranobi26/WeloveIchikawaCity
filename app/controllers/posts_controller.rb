class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def new
    @post = Post.new
    @post.images.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.score = params[:review][:score]
    #byebug

    if @post.save
      redirect_to post_path(@post.id),notice: "投稿に成功しました"
    else
     @post.images.new
     render "new"
    end
  end


  def index
    user=User.where(is_deleted: false)
    @posts =  Post.page(params[:page]).where(user_id: user.ids).reverse_order
    if params[:sort] == "low_star"
      @posts = Post.page(params[:page]).order(score: :asc)
    elsif params[:sort] == "high_star"
      @posts = Post.page(params[:page]).order(score: :desc)
    elsif params[:sort] == "low_ranking"
      # postとfavoritesを結合する＝joins。group=グループとして宣言したx.idの重複を避けるために用いる。post.id1つにつき、幾つのfavoriteがあるかをカウント(count)する
      @posts = Post.page(params[:page]).left_outer_joins(:favorites).group("posts.id").order("count(favorites.id) ASC").page(params[:page])
    elsif params[:sort] == "high_ranking"
      @posts = Post.page(params[:page]).left_outer_joins(:favorites).group("posts.id").order("count(favorites.id) DESC").page(params[:page])
    elsif params[:sort] == "old"
      @posts = Post.page(params[:page]).order(creatrd_at: :asc)
    elsif params[:sort] == "new"
      @posts = Post.page(params[:page]).order(creatrd_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @area = @post.area
    @images = @post.images
    @comment = Comment.new
    results = Geocoder.search(@area.postal_code)
    if results.first
      @cordinates = results.first.coordinates
    else
     @cordinates = [35.6809591, 139.7673068]
    end
  end

  def edit
    @post = Post.find(params[:id])
    if current_user != @post.user
      redirect_to request.referer
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.score = params[:review][:score]
    if @post.update(post_params)
      redirect_to post_path(@post.id),notice: "投稿の更新に成功しました"
    else
    render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :caption,:area_id, images_images: [])
  end
end
