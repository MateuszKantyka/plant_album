class MechanicsController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :update, :destroy]

  def new
    @mechanics = Mechanic.new
  end

  def index
    @mechanics = Mechanic.all
  end

  def edit
    @mechanic = Mechanic.find(params[:id])
  end

  def update
    @mechanic = Mechanic.find(params[:id])
    if @mechanic.update_attributes(mechanic_params)
      flash[:success] = 'Mechanics updated'
      redirect_to mechanics_path
    else
      flash[:danger] = 'Fill up all required fielsd'
      redirect_to edit_mechanic_path(@mechanic)
    end
  end

  def home
    @mechanics = Mechanic.where(:verification => true)
  end

  def destroy
    @mechanic = Mechanic.find(params[:id])
    @mechanic.destroy
    flash[:success] = 'Mechanic deleted'
    redirect_to mechanics_path
  end

  def create
    @mechanic = Mechanic.new(mechanic_params)
    @mechanic.verification = true if current_user.admin
    if @mechanic.save
      flash[:success] = 'Mechanic added, wait to admin to verificate' unless current_user.admin
      flash[:success] = 'Mechanic added' if current_user.admin
      redirect_to root_path
    else
      flash[:danger] = 'Fill up all required fielsd'
      redirect_to notification_path
    end
  end

  def show
    @mechanic = Mechanic.find(params[:id])
    @comments = @mechanic.comments
  end

private
  def mechanic_params
    params.require(:mechanic).permit(:name,:city,:post_code,:address,:rating,
                                 :phone_number, :description, :lat,:lng,:verification)
  end

  def admin_user
    if logged_in?
      redirect_to(root_url) unless current_user.admin
    else
      redirect_to(root_url)
    end
  end
end
