class UsersController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :update, :destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:danger] = "Correct the field"
      redirect_to edit_user_path(@user)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created"
      log_in @user
      redirect_to @user
    else
      flash[:danger] = "Correct the field"
      redirect_to signup_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User successfully destroyed"
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,
                                 :password_confirmation , :admin)
  end

  def admin_user
    if logged_in?
      redirect_to(root_url) unless current_user.admin
    else
      redirect_to(root_url)
    end
  end
end
