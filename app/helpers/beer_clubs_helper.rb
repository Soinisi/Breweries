module BeerClubsHelper
 
 def is_not_member(user, club)
  club.members.each do |member|
   if user == member
    return false
   end
  end
  true
 end
end
