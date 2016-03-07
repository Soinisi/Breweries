class RatingsController < ApplicationController
	before_action :is_cache, only:[:index]

	def index
	 	#Käytetty (toivon mukaan oikein)sidekiqia ja pumaa. Eli kahdella 
	 	#workerluokalla tehty taskit alla olevien arvojen hakuun (before_action :update_cache)
	 	#ja cachen päivitykseen. En ole ihan varma miksi ei lopuksi ehkä
	 	#toimi. . Käytin tähän
	 	#3h eikä enempää aikaa kokeilla 
	 	update_cache
	 	@ratings = Rating.all
		@new_ratings = Rating.recent
		@top_breweries = Brewery.top(3)
		@top_beers = Beer.top(3)
		@top_users = User.top(3)
		@top_styles = Style.top(3)
		

	end
	
	def new
		@rating = Rating.new
		@beers = Beer.all
	end
	
	def create
		expire_fragment('ratinglist')
		@rating = Rating.new params.require(:rating).permit(:score, :beer_id)
		
		#talletetaan tehdyt reittaukset sessioon
		#session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
		if @rating.save
			current_user.ratings << @rating
			redirect_to user_path current_user
		else
			@beers = Beer.all
			render :new
		end
	end
	
	def destroy
    expire_fragment('ratinglist')
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  	end

	def is_cache
		return render :index if fragment_exist?('ratinglist')
	end
	def update_cache  	
		
			@ratings = HardWorker.perform_in(1.minutes, 'ratings')
			@new_ratings = HardWorker.perform_in(1.minutes, 'new_ratings')
			@top_breweries = HardWorker.perform_in(1.minutes, 'top_breweries')
			@top_beers = HardWorker.perform_in(1.minutes, 'top_beers')
			@top_users = HardWorker.perform_in(1.minutes, 'top_users')
			@top_styles = HardWorker.perform_in(1.minutes, 'top_styles')
			ClearWorker.perform_in(2.minutes, 'ratinglist', 'views/ratings/index.html.erb')
		
		
	end
end
