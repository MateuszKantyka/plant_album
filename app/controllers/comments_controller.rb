class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "User successfully created"
    else
      redirect_to root_url
    end
  end

  def comment_params
    params.require(:comment).permit(:content,:car,:cost, :rating_general,
                                 :rating_cost, :rating_time)
  end

end
