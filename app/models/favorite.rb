class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :post

	#一人のユーザーが同じ投稿を複数回いいねを押すことを防ぐ為のバリデーション。
	validates_uniqueness_of :post_id, scope: :user_id
	
end
