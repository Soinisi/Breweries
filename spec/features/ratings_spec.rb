require 'rails_helper'
include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating1){ FactoryGirl.create :rating, score:20, beer_id:1 }
  let!(:rating1){ FactoryGirl.create :rating, score:10, beer_id:2 }
  before :each do
     sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.by(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  it "ratings page show number of and list of ratings" do
    expect(page).to have_content "Number of ratings #{user.ratings.count}"
    expect(page).to have_content "iso 3"
    expect(page).to have_content "Karhu"
  end
end