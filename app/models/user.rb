class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { maximum: 10 }
  validates :name, length: { minimum: 2 }
  validates :name, presence: true
  attachment :profile_image

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
