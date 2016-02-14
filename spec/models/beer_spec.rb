require 'rails_helper'

RSpec.describe Beer, type: :model do
  
  it "beer is saved if has name and style" do
  	beer = Beer.create name:"Kolmonen", style:"IPA"
  	
  	expect(beer).to be_valid
  	expect(Beer.count).to eq(1)
  end

  it "beer is not saved if it has no name" do
  	beer = Beer.create style:"IPA"
  	
  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end

  it "beer is not saved if it has no style" do
  	beer = Beer.create name:"Kolmonen"
  	
  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end

end
