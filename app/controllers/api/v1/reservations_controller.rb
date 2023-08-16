class Api::V1::ReservationsController < ApplicationController
  before_action :set_api_v1_reservation, only: %i[ show update destroy ]

  # GET /api/v1/reservations
  def index
    begin
      @api_v1_reservations = Reservation.all
      if @api_v1_reservations.present?
        render json: { success: true, details: @api_v1_reservations}
      else
        render json: { success: false, details: "No reservations found"}
      end
    rescue Exception => e
      render json: { success: false, details: e.message}
    end
  end

  # GET /api/v1/reservations/1
  def show
    render json: @api_v1_reservation
  end

  # POST /api/v1/reservations
  def create
    @api_v1_reservation = Reservation.new(api_v1_reservation_params)

    if @api_v1_reservation.save
      render json: { success: true, details: "Reservation created successfully" }
    else
      render json: { success: false, details: @api_v1_reservation.errors }
    end
  end

  # PATCH/PUT /api/v1/reservations/1
  def update
    if @api_v1_reservation.update(api_v1_reservation_params)
      render json: { success: true, details: "Reservation updated successfully"}
    else
      render json: { success: false, details: @api_v1_reservation.errors }
    end
  end

  # DELETE /api/v1/reservations/1
  def destroy
    if @api_v1_reservation.destroy
      render json: { success: true, details: "Reservation deleted successfully"}
    else
      render json: { success: false, details: @api_v1_reservation.errors}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_reservation
      @api_v1_reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_reservation_params
      params.require(:reservation).permit(:city, :date, :user_id, :car_id)
    end
end
