class Api::V1::CarsController < ApplicationController
  before_action :set_api_v1_car, only: [:show, :update, :destroy]

  # GET /api/v1/cars
  def index
    @api_v1_cars = Car.all
    if @api_v1_cars.present?
      render json: @api_v1_cars, status: :ok
    else
      render json: { message: 'No Cars Found' }, status: :not_found
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # GET /api/v1/cars/1
  def show
    render json: @api_v1_car, status: :ok
  end

  # POST /api/v1/cars
  def create
    @api_v1_car = Car.new(api_v1_car_params)

    if @api_v1_car.save
      render json: { message: 'Data saved successfully' }, status: :created
    else
      render json: { errors: @api_v1_car.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/cars/1
  def update
    if @api_v1_car.update(api_v1_car_params)
      render json: { message: 'Data updated successfully' }, status: :ok
    else
      render json: { errors: @api_v1_car.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/cars/1
  def destroy
    if @api_v1_car.destroy
      render json: { message: 'Data deleted successfully' }, status: :ok
    else
      render json: { errors: @api_v1_car.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_car
    @api_v1_car = Car.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Car not found' }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def api_v1_car_params

    params.require(:car).permit(:name, :price, :description, :front_image, :back_image, :interior_image)

  end
end
