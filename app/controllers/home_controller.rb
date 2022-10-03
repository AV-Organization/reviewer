class HomeController < ApplicationController
  def index
    @link = Link.all
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
  end

  private
  def params_method
    params.require(:link).permit(:title, :review, :link)
  end
end
