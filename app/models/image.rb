class Image < ApplicationRecord
	belongs_to :post
	attachment :image
end
