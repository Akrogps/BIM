require "pry"

class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :autocomplete]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:autocomplete]

  def index
    @restaurants = policy_scope(Restaurant).order(created_at: :desc)
    @restaurant = Restaurant.new

    @resto_list = Restaurant.search(where: {
      # name: /#{restaurant_params[:name]}/
      name: {like: "%#{restaurant_params[:name]}%"}
        # location: {near: {lat: address.lat, lon: address.lon}, within: "100mi"},
        # order: {_score: :desc}
      },
      # limit: 10,
      # offset: 50
    )
  end

  def show
  end

  def new
    @restaurant = current_user.restaurants.new
    authorize @restaurant
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    @restaurant.images.build(remote_cloudinary_url_url: "https://source.unsplash.com/random/1600x900/?restaurant")
    authorize @restaurant

    if @restaurant.save
      redirect_to restaurant_path(@restaurant), notice: "restaurant created"
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

  def autocomplete
    @restaurants = Restaurant.search(params[:query], {
      fields: [:name],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 0}
    }).map(&:name)

    render json: @restaurants
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :description, :content, :website, :phone_number, :opening_hours, :price_indication)
  end
end
