class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_back(fallback_location: root_path)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(product_id: params[:product_id], user_id: current_user.id)
  end
end
