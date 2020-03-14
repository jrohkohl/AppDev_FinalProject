class StatisticsController < ApplicationController
  def index
    @statistics = Statistic.all.order({ :created_at => :desc })

    render({ :template => "statistics/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @statistic = Statistic.where({:id => the_id }).at(0)

    render({ :template => "statistics/show.html.erb" })
  end

  def create
    @statistic = Statistic.new
    @statistic.restaurant_id = params.fetch("query_restaurant_id")
    @statistic.average_rating = params.fetch("query_average_rating")
    @statistic.count_ratings = params.fetch("query_count_ratings")

    if @statistic.valid?
      @statistic.save
      redirect_to("/statistics", { :notice => "Statistic created successfully." })
    else
      redirect_to("/statistics", { :notice => "Statistic failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @statistic = Statistic.where({ :id => the_id }).at(0)

    @statistic.restaurant_id = params.fetch("query_restaurant_id")
    @statistic.average_rating = params.fetch("query_average_rating")
    @statistic.count_ratings = params.fetch("query_count_ratings")

    if @statistic.valid?
      @statistic.save
      redirect_to("/statistics/#{@statistic.id}", { :notice => "Statistic updated successfully."} )
    else
      redirect_to("/statistics/#{@statistic.id}", { :alert => "Statistic failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @statistic = Statistic.where({ :id => the_id }).at(0)

    @statistic.destroy

    redirect_to("/statistics", { :notice => "Statistic deleted successfully."} )
  end
end
