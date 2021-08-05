class ShortenedUrl < ApplicationRecord 

  validates :long_url, :short_url, :user_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter, 
    primary_key: :id, 
    foreign_key: :submitted_user_id 
    class_name: :User 
  
  has_many :visits
    primary_key: :id, 
    foreign_key: :shortend_url_id
    class_name: :ShortenedUrl

  
  has_many :visitors,
      # -> { distinct }  using count unique or this it's upt to me 3>
      through: :visits,
      source: :visitor

  has_many: tagging, 
    primary_key: :id, 
    foreign_key: :shortend_url_id 
    class_name: :ShortenedUrl
  
    has_many :tag_topics, 
      through: :tagging, 
      source: :tag_topic

  
  def self.genrate_short_url(long_url, user)
    ShortenedUrl.create!( 
      submitted_user_id: user.id, 
      long_url: long_url, 
      short_url: ShortenedUrl.random_code
    )
  end 

  def self.random_code 
    loop do 
      random_code = SecureRandom.urlsafe_base64(16)
      return random_code unless ShortenedUrl.exeists(short_url: random_code)
    end 
  end 

  def num_clicks 
    visits.count
  end 

  def num_unquene 
    visits.select('user_id').distinct.count 
  end 
  
  def num_recent_unqueness 
    visits.select('user_id')
    .where('created_at > ?', 10.minutes.ago)
    .distinct
    .count 
  end 


  def self.prune(n)
    ShortenedUrl
      .joins(:submitter)
      .joins('LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id')
      .where("(shortened_urls.id IN (
        SELECT shortened_urls.id
        FROM shortened_urls
        JOIN visits
        ON visits.shortened_url_id = shortened_urls.id
        GROUP BY shortened_urls.id
        HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
      ) OR (
        visits.id IS NULL and shortened_urls.created_at < \'#{n.minutes.ago}\'
      )) AND users.premium = \'f\'")
      .destroy_all




  # Custom Validations 

  private 


  def no_spamming 
    last_minute = ShortenedUrl.where('created_at >= ?', 1.minute.ago)
      .where(submitted_user_id: submitted_user_id)
      .length 


    errors[:maximum] << 'of five short urls per minutes' if last_minute >= 5 
  end 

  def nonpremium_max 
    return if User.find(self.submitted_user_id).premium 

    number_of_urls = 
      ShortenedUrl.where(submitted_user_id: submitted_user_id).length 

    if number_of_urls >= 5 
      errors[:Only] < 'premium numbers' 
    end 
  end 
end 





end 