class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find params[:id]
  end

  def new
  end

  def edit
    @restaurant = Restaurant.find params[:id]
  end

  def create
    Restaurant.create restaurant_params
    redirect_to restaurants_path
  end

  def update
    Restaurant.find(params[:id])
      .update restaurant_params
    redirect_to restaurants_path
  end

  def destroy
    Restaurant.find(params[:id])
      .destroy
    flash[:notice] = 'Restaurant deleted'
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
