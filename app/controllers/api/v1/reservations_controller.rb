class Api::V1::ReservationsController < ApplicationController
  before_action :set_api_v1_reservation, only: %i[show update destroy]

  # GET /api/v1/reservations
  def index
    @api_v1_reservations = Reservation.all
    if @api_v1_reservations.present?
      render json: @api_v1_reservations, status: :ok
    else
      render json: { message: 'No reservations found' }, status: :not_found
    end
  rescue StandardError
    render json: { error: e.message }, status: :internal_server_error
  end

  # GET /api/v1/reservations/1
  def show
    render json: @api_v1_reservation, status: :ok
  end

  # POST /api/v1/reservations
  def create
    @api_v1_reservation = Reservation.new(api_v1_reservation_params)

    if @api_v1_reservation.save
      render json: { message: 'Reservation created successfully' }, status: :created
    else
      render json: { errors: @api_v1_reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/reservations/1
  def update
    if @api_v1_reservation.update(api_v1_reservation_params)
      render json: { message: 'Reservation updated successfully' }, status: :ok
    else
      render json: { errors: @api_v1_reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/reservations/1
  def destroy
    if @api_v1_reservation.destroy
      render json: { message: 'Reservation deleted successfully' }, status: :ok
    else
      render json: { errors: @api_v1_reservation.errors.full_messages }, status: :unprocessable_entity
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
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservations not found' }, status: :not_found
  end
end
