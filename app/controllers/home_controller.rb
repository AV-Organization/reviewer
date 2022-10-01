class HomeController < ApplicationController
  def index
    @link = Link.all
  end
end
