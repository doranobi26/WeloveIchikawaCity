class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    #@users = User.page(params[:page]).reverse_order
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def index
    #@users = User.where("id != " + current_user).page(params[:page]).reverse_order
    @users = User.page(params[:page]).reverse_order

  end

  def profile
    @user = User.find(params[:id])
  end

  def favorite
    @favorites = Favorite.page(params[:page]).where(user_id: params[:id]).reverse_order
    #@favorites = Favorite.where(user_id :user.id)
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
      #flash[:notice] = 'プロフィール情報の更新に成功しました'
      redirect_to user_profile_path(@user.id),notice: "プロフィール情報の更新に成功しました"
    #binding.pry
    else
      render "edit"
    end
  end

  def hide
    @user = User.find(current_user.id)
    @user.update!(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
