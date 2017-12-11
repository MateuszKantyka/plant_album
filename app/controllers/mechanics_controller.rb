class MechanicsController < ApplicationController

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
      flash[:success] = "Mechanics updated"
      redirect_to request.referrer
    else
      flash[:success] = "Error"
      redirect_to request.referrer
    end
  end

  def home
    @mechanics = Mechanic.where(:verification => true)
  end

  def destroy
    @mechanic = Mechanic.find(params[:id])
    @mechanic.destroy
    flash[:success] = "Mechanic deleted"
    redirect_to request.referrer
  end

  def create
    @mechanic = Mechanic.new(mechanic_params)
    @mechanic.verification = true if current_user.admin
    if @mechanic.save
      flash[:success] = "Mechanic added, wait to admin to verificate"
      redirect_to request.referrer
    else
      redirect_to request.referrer
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


end
