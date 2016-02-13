class User < ActiveRecord::Base
include RatingAverage
 
validates :username, uniqueness: true
validates :username, length: {minimum: 3, maximum: 15}
 

has_many :ratings, dependent: :destroy   # käyttäjällä on monta ratingia
has_many :beers, through: :ratings
has_many :memberships
has_many :beer_clubs, through: :memberships

end
