include Pagy::Frontend
module ApplicationHelper
  def stars(likes,dislikes)
    if likes > 0
      sum = likes.to_f + dislikes.to_f
      sum = ((likes.to_f/sum.to_f)*10)/2
      total = 5-sum.round()
      ((' <i class="fa-solid fa-star"></i> '* sum.round)+ (' <i class="fa-regular fa-star"></i> '*total)).html_safe
    else
      (' <i class="fa-regular fa-star"></i> '*5).html_safe
    end
  end
end
