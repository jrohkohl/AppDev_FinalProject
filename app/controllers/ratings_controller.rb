class RatingsController < ApplicationController
  def index
    @ratings = Rating.all.order({ :created_at => :desc })

    render({ :template => "ratings/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @rating = Rating.where({:id => the_id }).at(0)

    render({ :template => "ratings/show.html.erb" })
  end

  def create
    @rating = Rating.new
    @rating.user_id = @current_user.id
    @rating.restaurant_id = params.fetch("query_restaurant_id")
    @rating.rating = params.fetch("query_rating")
    @rating.comment = params.fetch("query_comment")

    if @rating.valid?
      @rating.save
      redirect_to("/get_started", { :notice => "Rating created successfully." })
    else
      redirect_to("/get_started", { :notice => "Rating failed to create successfully." })
    end
  end

  def open_edit

    the_id = params.fetch("path_id")
    @open_rating = Rating.new
    @open_rating.user_id = @current_user.id
    @open_rating.restaurant_id = Rating.where({ :id => the_id }).at(0).restaurant_id
    @open_rating.rating = Rating.where({ :id => the_id }).at(0).rating
    @open_rating.comment = Rating.where({ :id => the_id }).at(0).comment


    session.store(:edit_rest_id, @open_rating.restaurant_id)
    

    

    render({ :template => "ratings/start.html.erb" })


  end

  def update
    the_id = params.fetch("path_id")
    @rating = Rating.where({ :id => the_id }).at(0)

    @rating.user_id = @current_user.id
    @rating.restaurant_id = params.fetch("query_restaurant_id")
    @rating.rating = params.fetch("query_rating")
    

    if @rating.valid?
      @rating.save
      redirect_to("/get_started", { :notice => "Rating updated successfully."} )
    else
      redirect_to("/get_started", { :alert => "Rating failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @rating = Rating.where({ :id => the_id }).at(0)

    @rating.destroy

    redirect_to("/get_started", { :notice => "Rating deleted successfully."} )
  end
end
