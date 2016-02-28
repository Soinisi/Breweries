class Rating < ActiveRecord::Base
	include RatingAverage
	belongs_to :beer
	belongs_to :user 
	validates :score, numericality: {greater_than_or_equal_to: 1, 
  	less_than_or_equal_to: 50, only_integer: true}

 	scope :recent, -> {Rating.order(created_at: :desc).last(5)}
	
	def to_s
		"#{self.beer.name} #{self.score}"
	end

end

