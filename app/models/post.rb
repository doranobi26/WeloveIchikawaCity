class Post < ApplicationRecord
	has_many :images, dependent: :destroy
	accepts_attachments_for :images, attachment: :image
end
