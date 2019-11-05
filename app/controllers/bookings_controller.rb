class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking).where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @booking = current_user.bookings.new
    authorize @booking
  end

  def create
    @booking = current_user.bookings.new(booking_params)
    authorize @booking

    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:participants, :date)
  end
end
