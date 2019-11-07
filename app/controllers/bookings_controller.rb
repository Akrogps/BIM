class BookingsController < ApplicationController
  before_action :set_restaurant, only: [:new, :create]

  def index
    @bookings = policy_scope(Booking).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @booking = current_user.bookings.new
    authorize @booking
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    @booking.restaurant = @restaurant
    authorize @booking

    if @booking.save
      redirect_to restaurant_path(@restaurant), notice: "booking created"
    else
      render :new
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def booking_params
    params.require(:booking).permit(:participants, :date)
  end
end
