class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  
  validates :name, presence: true
  validates :year, numericality: {less_than_or_equal_to: Proc.new {Time.now.year}}

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }
  
 def self.top(n)
    Brewery.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
 end 


  def print_report
  	puts name
  	puts "established at year #{year}"
  	puts "number of beers #{beers.count}"
  end
  
  def restart
  	self.year = 2016
  	puts"changed year to #{year}"
  end

end
