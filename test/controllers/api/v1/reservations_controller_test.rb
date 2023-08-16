require 'test_helper'

class Api::V1::ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_reservation = api_v1_reservations(:one)
  end

  test 'should get index' do
    get api_v1_reservations_url, as: :json
    assert_response :success
  end

  test 'should create api_v1_reservation' do
    assert_difference('Api::V1::Reservation.count') do
      post api_v1_reservations_url,
           params: {
             api_v1_reservation: {
               car_id: @api_v1_reservation.car_id,
               city: @api_v1_reservation.city,
               date: @api_v1_reservation.date,
               user_id: @api_v1_reservation.user_id
             }
           }, as: :json
    end

    assert_response :created
  end

  test 'should show api_v1_reservation' do
    get api_v1_reservation_url(@api_v1_reservation), as: :json
    assert_response :success
  end

  test 'should update api_v1_reservation' do
    patch api_v1_reservation_url(@api_v1_reservation),
          params: {
            api_v1_reservation: {
              car_id: @api_v1_reservation.car_id,
              city: @api_v1_reservation.city,
              date: @api_v1_reservation.date,
              user_id: @api_v1_reservation.user_id
            }
          }, as: :json
    assert_response :success
  end

  test 'should destroy api_v1_reservation' do
    assert_difference('Api::V1::Reservation.count', -1) do
      delete api_v1_reservation_url(@api_v1_reservation), as: :json
    end

    assert_response :no_content
  end
end
