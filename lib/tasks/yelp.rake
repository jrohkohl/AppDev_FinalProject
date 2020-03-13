task({:yelp=> :environment}) do 

  Rating.destroy_all
  Restaurant.destroy_all

end