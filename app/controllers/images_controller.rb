class ImagesController < ApplicationController
  before_action :set_restaurant, only: [:new, :create]

  def new
    @image = @restaurant.images.new
  end

  def create
    @image = @restaurant.images.new(image_params)
    @image.restaurant = @restaurant

    if @image.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def image_params
    params.require(:image).permit(:cloudinary_url)
  end
end
