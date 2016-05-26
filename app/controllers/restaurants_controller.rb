class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find params[:id]
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find params[:id]
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    if @restaurant.save
      redirect_to restaurants_path
    else
      render :new
    end
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
