class SearchsController < ApplicationController

  before_action :authenticate_user!

 def search
   @user_or_post = params[:option]
   @how_search = params[:choice]
   @search = params[:search]
    if @user_or_post == "1"
       @users = User.search(params[:search], @user_or_post)
    elsif @user_or_post == "2"
       @posts = Post.search(params[:search], @user_or_post)
    else
       @user=User.all
     end
   end
end
