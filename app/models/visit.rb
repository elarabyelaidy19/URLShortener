class visit < ApplicationRecord 

  validates :visitor, :shortend_url, presence: true 

  belongs_to :shortened_url, 
    class_name: :ShortenedUrl,
    primary_key: :id, 
    foreign_key: :shortend_url_id

  belongs_to :visitor, 
    class_name: :User, 
    primary_key: :id 
    foreign_key: :user_id 


    # create a Visit object recording a visit from a User to the given ShortenedUrl
    def self.record_visit!(user, shortend_url) 
      Visit.create!(user_id: user.id, shortend_url_id: shortened_url.id) 
    end 
end 

