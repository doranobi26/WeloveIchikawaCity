class Post < ApplicationRecord

	validates :title, presence: true
	validates :title, length: { maximum: 200 }
	validates :caption, presence: true
	validates :caption,  length: { maximum: 200 }

	belongs_to :user
	belongs_to :area
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :images, dependent: :destroy
	accepts_attachments_for :images, attachment: :image

	def favorited_by?(user)
	 favorites.where(user_id: user_id).exists?
	end
end
