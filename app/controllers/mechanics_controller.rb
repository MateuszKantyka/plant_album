class MechanicsController < ApplicationController

  def index
    @mechanics = Mechanic.all
  end

  def show
    @mechanic = Mechanic.find(params[:id])
    #@comment = Comment.find_by(mechanic_id: 1)
    @comment = Comment.find(:all, :conditions => { :mechanic_id => 1 })
  end
end
