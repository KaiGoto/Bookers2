class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    @books = @user.books.all
  end
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.all
  end
  def edit
    @user = User.find(params[:id])
    if @user !=current_user
      redirect_to user_path(current_user)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ='Book was successfully created.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] ='Book was successfully created.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  def follow
    @user = User.find(params[:user_id])
  end
  def follower
    @user = User.find(params[:user_id])
  end
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
