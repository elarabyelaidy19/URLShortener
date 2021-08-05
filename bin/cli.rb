class CLI 

  def create_url 
    puts 'type in your long url' 
    long_url = gets.chomp 
    shortend_url = ShortenedUrl.genrate_short_url(@current_user, long_url) 
    puts "short url is #{shortend_url.short_url}"
  end 

  def login_user! 
    puts 'input your email' 
    @current_user = User.find_by(email: gets.chomp) 
    raise 'that user does not exit' if @current_user.nil? 

    nil 
  end 

  def run 
    login_user! 

    puts 'What do you want to do?'
    puts '0. Create shortened URL'
    puts '1. Visit shortened URL'
    
    option = Integer(gets.chomp) 
    case option 
    when 0 
      create_url
    when 1 
      visit_url 
    end 
  end 

  def visit_url 
    puts 'type in shortend url' 
    short_url = gets.chomp 

    shortend_url = ShortenedUrl.find_by(short_url: short_url) 
    raise 'no such url found' if shortend_url.nil?

    Visit.record_visit(@current_user, shortend_url) 
    Launchy.open(shortend_url.long_url) 
  end 
end 

ClI.new.run 

