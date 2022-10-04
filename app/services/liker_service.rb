# frozen_string_literal: true
# app/services/home_services.rb
class LikerService
  attr_reader :current_user

  def initialize(link,bool,user)
    @link = link
    @bool = bool
    @current_user = user
  end

  def call
    if @bool == 'true'
      if current_user.voted_for? @link
        @link.unliked_by current_user
      else
        @link.liked_by current_user
      end
    elsif @bool == 'false'
      if current_user.voted_for? @link
        @link.undisliked_by current_user
      else
        @link.disliked_by current_user
      end
    end
  end
end