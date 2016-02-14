require 'rails_helper'
include Helpers

describe "Beer" do
  #before :each do
  #  FactoryGirl.create(:beer)
  #end

  describe "beer validation" do

  	it "if beer has a name it is saved" do
  		visit new_beer_path
  		fill_in('beer[name]', with:"uusi")
  		expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
	end
  	
  	it "if beer has not a name it is not saved" do
  		visit new_beer_path
  	
      click_button('Create Beer')
      page.should have_content("Name can't be blank")  
      expect(Beer.count).to eq(0)	
	end

  end
end
