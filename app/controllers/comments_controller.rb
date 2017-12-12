class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      refresh_rating(@comment)
      flash[:success] = "Comment successfully created"
      redirect_to request.referrer
    else
      flash[:danger] = "Fill in all fields"
      redirect_to request.referrer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    refresh_rating(@comment)
    @comment.destroy
    flash[:success] = "Comment successfully destroyed"
    redirect_to request.referrer
  end

  def comment_params
    params.require(:comment).permit(:content,:car,:cost, :rating_general,
                                 :rating_cost, :rating_time, :mechanic_id)
                                 .merge(user_id: current_user.id)
  end

  def refresh_rating(comment)
    mechanic = Mechanic.find(comment.mechanic_id)
    rating = 0.0
    i = 0
    mechanic.comments.each do |comment|
      rating = rating + ((comment.rating_cost + comment.rating_time + comment.rating_general) / 3)
      i = i+1
    end
    mechanic.update_attribute(:rating,rating / i)
  end
end
