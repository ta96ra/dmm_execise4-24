class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post_image
  # posts_commentモデルは、userモデルとpost_imageモデルに所属している
  #1:NのN側
end
