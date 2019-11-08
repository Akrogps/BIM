class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @restaurants = Restaurant.all
    @restaurant = Restaurant.new
  end
end
