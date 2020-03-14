class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all.order({ :created_at => :desc })

    render({ :template => "restaurants/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @restaurant = Restaurant.where({:id => the_id }).at(0)

    render({ :template => "restaurants/show.html.erb" })
  end

  def search_restaurant

    require "open-uri"
    require "json"
    require "optparse"
    require "http"

    
    
    r_name = params.fetch("rest_name")

    if Restaurant.where({:name => r_name }).at(0).present?

      @searched_restaurant = Restaurant.new

      @searched_restaurant.name = Restaurant.where({:name => r_name }).at(0).name

      @searched_restaurant.address = Restaurant.where({:name => r_name }).at(0).address

      @searched_restaurant.category = Restaurant.where({:name => r_name }).at(0).category

      @searched_restaurant.image = Restaurant.where({:name => r_name }).at(0).image
      

      session.store(:searched_restaurant_id, @searched_restaurant.id)
      session.store(:searched_restaurant_address, @searched_restaurant.address)
      
    
    else



      api_host = "https://api.yelp.com"
      search_path = "/v3/businesses/search"
      business_path = "/v3/businesses/"

    
      
      api_key = "ci6hmeh54tejgwdcH-EXsay0qkr0FwKmjfjv2SlQu-nxvDfCPcddx8-1eolGCrMkTpz88anJhG4yKFejJtfkivOlrUF0qGpqsQS6ajk30InpMWm-NduCBmouTHldXnYx"
      url = "#{api_host}#{search_path}"
      params = {
        term: "#{r_name}",
        location: "Chicago",
        limit: 5
      }

      response = HTTP.auth("Bearer #{api_key}").get(url, params: params)
      businesses = JSON.parse(response)

      name_result = businesses.fetch("businesses").at(0).fetch("name")
      address_result = businesses.fetch("businesses").at(0).fetch("location").fetch("address1")
      img_result = businesses.fetch("businesses").at(0).fetch("image_url")
      cat_result = businesses.fetch("businesses").at(0).fetch("categories").at(0).fetch("title")


      @searched_restaurant = Restaurant.new

      @searched_restaurant.name = name_result

      @searched_restaurant.address = address_result 

      @searched_restaurant.image = img_result 

      @searched_restaurant.category = cat_result

     

      


    end

   

    render({ :template => "/ratings/start.html.erb" })
    


  end

  def create
    
    @restaurant = Restaurant.new
    @restaurant.name = params.fetch("query_name")
    @restaurant.address = params.fetch("query_address")
    @restaurant.category = params.fetch("query_category")
    @restaurant.image = params.fetch("query_image")

    if @restaurant.in_db.present?

      

      @restaurant.id = @restaurant.in_db.id
      render({ :template=> "/ratings/start.html.erb"})

    else

    

      if @restaurant.valid?
        @restaurant.save

        @statistic = Statistic.new
        @statistic.restaurant_id = @restaurant.id
        @statistic.average_rating = 0
        @statistic.count_ratings = 0
        @statistic.save

        render({ :template=> "/ratings/start.html.erb"})
      else
        render({ :template=> "/ratings/start.html.erb"})
      end
    end
  end

  def update
    the_id = params.fetch("path_id")
    @restaurant = Restaurant.where({ :id => the_id }).at(0)

    @restaurant.name = params.fetch("query_name")
    @restaurant.address = params.fetch("query_address")
    @restaurant.category = params.fetch("query_category")
    @restaurant.image = params.fetch("query_image")

    if @restaurant.valid?
      @restaurant.save
      render({ :template=> "/ratings/start.html.erb"}, { :notice => "Restaurant created successfully." })
    else
      render({ :template=> "/ratings/start.html.erb"}, { :notice => "Restaurant failed to create successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @restaurant = Restaurant.where({ :id => the_id }).at(0)

    @restaurant.destroy

    redirect_to("/restaurants", { :notice => "Restaurant deleted successfully."} )
  end
end
