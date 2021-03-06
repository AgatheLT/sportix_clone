class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    @booking = Booking.new(booking_date: params[:booking_date])
    @sport_session = SportSession.find(params[:sport_session_id])
    @booking.sport_session = @sport_session
    @booking.user = current_user
    @booking.save!
    if @booking.save
      flash[:notice] = "Sport Session successfully booked!"
      redirect_to user_path(current_user)
    else
      render :sport_session
    end
    authorize(@booking)
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize(@booking)
    @booking.destroy
    flash[:alert] = "Booking deleted"
    redirect_to user_path(current_user)
  end
end
