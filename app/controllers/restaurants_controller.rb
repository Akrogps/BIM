class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = policy_scope(Restaurant).order(created_at: :desc)
  end

  def show
  end

  def new
    @restaurant = current_user.restaurants.new
    authorize @restaurant
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    authorize @restaurant

    if @restaurant.save
      redirect_to new_restaurant_image_path(@restaurant)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)

    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant.destroy

    redirect_to root_path
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :description, :content, :website, :opening_hours)
  end
end
