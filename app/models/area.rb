class Area < ApplicationRecord
  has_many :posts

  validates :name, presence: true
  #validates :postal_code, presence: true
end