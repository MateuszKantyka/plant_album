class UsersController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :update]

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to request.referrer
    else
      flash[:success] = "Error"
      redirect_to request.referrer
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to request.referrer
  end

  def show
    @user = User.find(params[:id])
  end

private

  def user_params
    params.require(:user).permit(:name,:email,:password,
                                 :password_confirmation, :admin)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin
  end
end
