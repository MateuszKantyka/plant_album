class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "User successfully created"
      redirect_to request.referrer
    else
      redirect_to request.referrer
    end
  end

  def comment_params
    params.require(:comment).permit(:content,:car,:cost, :rating_general,
                                 :rating_cost, :rating_time, :mechanic_id)
                                 .merge(user_id: current_user.id)
  end
end
