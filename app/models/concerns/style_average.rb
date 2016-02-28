module StyleAverage
  extend ActiveSupport::Concern

	def style_average
		return 0 if beers.empty?
		
		b = 0.0
		i = 0
		
		style.beers.each do |beer|
				
					style.beer.ratings.each do |rating|	
						if rating.score
							b = b + rating.score
							i = i + 1
						end
			end
		end
		
		return b / i
	end
end
