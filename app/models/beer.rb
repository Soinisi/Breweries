class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

	#def average_rating
 	#sum = 0.0
 	#if self.ratings.count != 0 
 		
 	#	self.ratings.each do |rating|
 	#		sum = sum + rating.score
 	#	end
 	#end
 	#
 	#return "#{sum / self.ratings.count}"
 #end
	#return self.ratings.inject(0.0){|sum, rating| sum + rating.score } / self.ratings.count
	#end

	def to_s
		"#{self.name} #{self.brewery.name}"
	end
end
