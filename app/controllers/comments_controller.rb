class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      RefreshRating.call(Mechanic.find(@comment.mechanic_id))
      flash[:success] = 'Comment successfully created'
      redirect_to mechanic_path(@comment.mechanic)
    else
      flash[:danger] = 'Fill in all fields'
      redirect_to mechanic_path(@comment.mechanic)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    RefreshRating.call(Mechanic.find(@comment.mechanic_id))
    flash[:success] = 'Comment successfully destroyed'
    redirect_to @comment.mechanic
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:car,:cost, :rating_general,
                                 :rating_cost, :rating_time, :mechanic_id)
                                 .merge(user_id: current_user.id)
  end
end
