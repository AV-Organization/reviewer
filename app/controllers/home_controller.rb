class HomeController < ApplicationController
  def index
    @q = Link.ransack(params[:q])
    @links = @q.result(distinct: true)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params_method)
    if @link.save
      redirect_to root_path
    else
      flash[:errors] = @link.errors.full_messages
      redirect_to new_home_path
    end
  end

  def show
    @link = Link.find(params[:id])
    @comment = Comment.new
    @comments = @link.comments.all
    flash[:back] = home_path(params[:id])
  end

  def comment_create
    @link = Link.find(params[:comment][:commentable])
    @comment = Comment.new(params_comment)
    @comment.commentable = @link
    @comment.user = current_user
    @comment.save
    flash[:errors] = 'error creating comment' if @comment.errors.any?
    redirect_to flash[:back]
  end

  def likeable
    @link = Link.find(params[:id])
    if params[:bool] == 'true'
      if current_user.voted_for? @link
        @link.unliked_by current_user
      else
        @link.liked_by current_user 
      end
    elsif params[:bool] == 'false'
      if current_user.voted_for? @link
        @link.undisliked_by current_user
      else
        @link.disliked_by current_user 
      end
    end
    redirect_to home_path(params[:id])
  end
  private

  def params_method
    params.require(:link).permit(:title, :review, :link)
  end

  def params_comment
    params.require(:comment).permit(:body)
  end
end
