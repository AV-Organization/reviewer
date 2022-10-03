class HomeController < ApplicationController
  def index
    @links = Link.all
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
    @comments = Comment.all
    flash[:back] = home_path(params[:id])
  end

  def comment_create
    @comment = Comment.new(params_comment)
    @comment.commentable = current_user
    @comment.save
    flash[:errors] = 'error creating comment' if @comment.errors.any?
    redirect_to flash[:back]
  end

  private

  def params_method
    params.require(:link).permit(:title, :review, :link)
  end

  def params_comment
    params.require(:comment).permit(:body)
  end
end
