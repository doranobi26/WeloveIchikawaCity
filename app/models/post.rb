class Post < ApplicationRecord

  #after_validation :geocode

	validates :title, presence: true
	validates :title, length: { maximum: 20 }
	validates :caption, presence: true
	validates :caption,  length: { maximum: 300 }
	validates :score, numericality: {
               less_than_or_equal_to: 5.0, #指定された値と等しいか、それよりも小さくなければならないことを指定
               greater_than_or_equal_to: 0.5 #指定された値と等しいか、それよりも大きくなければならないことを指定
               }, presence: true
	validate :presence_images

	belongs_to :user
	belongs_to :area
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :images, dependent: :destroy
	accepts_attachments_for :images, attachment: :image

	def favorited_by?(user)
	 favorites.where(user_id: user.id).exists?
	end

	def Post.search(search, user_or_post)
    if user_or_post == "2"
    	if search == ""
    	   Post.where(['title LIKE ?',"#{search}" ])
    	else
           Post.where(['title LIKE ?', "%#{search}%"])
        end
    end
    end

    #def self.ranking(params)
    	#if params[:sort] == "low_ranking"
    	#end
    #end

    private

    def presence_images
    	errors.add(:posts, "can't be blank") if images.size == 0
    end

    #def geocode
      #uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=ENV["GOOGLEMAP_API_KEY"]")
      #res = HTTP.get(uri).to_s
      #response = JSON.parse(res)
      #self.latitude = response["results"][0]["geometry"]["location"]["lat"]
      #self.longitude = response["results"][0]["geometry"]["location"]["lng"]
    #end
end
