class Image < ApplicationRecord

	#validates :image_id, presence: true

	belongs_to :post
	attachment :image
end
