class Style < ActiveRecord::Base
	include RatingAverage
	include StyleAverage
	has_many :beers

def self.top(n)
    
    
 		
 end 




end
