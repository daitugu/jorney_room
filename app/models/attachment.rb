class Attachment < ApplicationRecord
  has_one_attached :image
   belongs_to :post
end
