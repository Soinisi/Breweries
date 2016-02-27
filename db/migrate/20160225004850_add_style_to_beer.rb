class AddStyleToBeer < ActiveRecord::Migration
  def change
  	add_reference(:beers, :style)
  end
end
