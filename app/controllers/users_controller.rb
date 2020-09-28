class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    if @user.is_deleted == false
      @posts = @user.posts.page(params[:page]).reverse_order
    else
      redirect_to root_path
    end
  end

  def index
    # 退会したユーザーとadminを除いたテーブルeach表記処理
    @users = User.page(params[:page]).where(is_deleted: false).where(admin: false).reverse_order
  end

  def profile
    @user = User.where(id: params[:id], is_deleted: false).first
    if @user.present?
    else
      redirect_to root_path
    end
  end

  def favorite
    @favorites = Favorite.page(params[:page]).where(user_id: params[:id]).reverse_order
    #@favorites = User.page(params[:page]).where(is_deleted: false).where(admin: false).reverse_order
  end



  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_profile_path(@user.id),notice: "プロフィール情報の更新に成功しました"
    else
      render "edit"
    end
  end

  def hide
    @user = User.find(params[:id])
    @user.update!(is_deleted: true)
    Favorite.where(user_id: @user.id).destroy_all
    Post.where(user_id: @user.id).destroy_all
    Comment.where(user_id: @user.id).destroy_all
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
