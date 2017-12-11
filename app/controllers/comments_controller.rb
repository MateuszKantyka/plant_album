class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment successfully created"
      redirect_to request.referrer
    else
      flash[:danger] = "Fill in all fields"
      redirect_to request.referrer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment successfully destroyed"
    redirect_to request.referrer
  end

  def comment_params
    params.require(:comment).permit(:content,:car,:cost, :rating_general,
                                 :rating_cost, :rating_time, :mechanic_id)
                                 .merge(user_id: current_user.id)
  end
end
