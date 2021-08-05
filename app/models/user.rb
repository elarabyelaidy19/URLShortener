class User < ApplicationRecord 

  validates :email, uniqueness: true, presence: true 

  has_many :submitted_urls, 
    primary_key: :id, 
    foreign_key: :submitted_user_id, 
    class: :ShortenedUrl

  has_many: :visits
    primary_key: :id, 
    foreign_key :user_id 
    class_name: :USer 

  has_many: :visited_urls, 
      through: :visits, 
      source: :shortened_Url
  
end 