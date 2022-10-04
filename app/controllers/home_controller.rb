class HomeController < ApplicationController
  def index
    Pagy::DEFAULT[:items] = 9
    @q = Link.ransack(params[:q])
    @pagy,@links = pagy(@q.result)
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
    @link = Link.find_by(id: params[:comment][:commentable])
    @comment = current_user.comments.new(params_comment)
    @comment.commentable = @link
    @comment.save
    flash[:errors] = @comment.errors.full_message if @comment.errors.any?
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
    respond_to do |format|
      format.turbo_stream { render partial: 'partials/likeable', locals: {link: @link} }
    end
  end
  private

  def params_method
    params.require(:link).permit(:title, :review, :link)
  end

  def params_comment
    params.require(:comment).permit(:body)
  end
end
