class Api::V1::CarsController < ApplicationController
  before_action :set_api_v1_car, only: %i[show update destroy]

  # GET /api/v1/cars
  def index
    @api_v1_cars = Car.all
    if @api_v1_cars.present?
      render json: { success: true, details: @api_v1_cars }
    else
      render json: { success: false, details: 'No Users Found' }
    end
  rescue StandardError => e
    render json: { success: false, details: e.message }
  end

  # GET /api/v1/cars/1
  def show
    render json: @api_v1_car
  end

  # POST /api/v1/cars
  def create
    @api_v1_car = Car.new(api_v1_car_params)

    if @api_v1_car.save
      render json: { success: true, details: ' Data saved successfully' }
    else
      render json: { success: false, details: @api_v1_car.errors }
    end
  end

  # PATCH/PUT /api/v1/cars/1
  def update
    if @api_v1_car.update(api_v1_car_params)
      render json: { success: true, details: 'Data updated successfully' }
    else
      render json: { success: false, details: @api_v1_car.errors }
    end
  end

  # DELETE /api/v1/cars/1
  def destroy
    if @api_v1_car.destroy
      render json: { success: true, details: 'Data deleted successfully' }
    else
      render json: { success: false, details: @api_v1_car.errors }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_car
    @api_v1_car = Car.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_car_params
    params.require(:car).permit(:name, :price)
  end
end
