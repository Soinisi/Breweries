class HardWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  def perform(name)
    
    case name
    	when 'ratings' then return Rating.all
    	when 'new_ratings' then return Rating.recent
    	when 'top_breweries' then return Brewery.top(3)
    	when 'top_beers' then return Beer.top(3)
    	when 'top_users' then return User.top(3)
    	when 'top_styles' then return Style.top(3)
  	end
		
  end
end