require 'test_helper'

class TemperaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @temperature = temperatures(:one)
  end

  test "should get index" do
    get temperatures_url, as: :json
    assert_response :success
  end

  test "should create temperature" do
    assert_difference('Temperature.count') do
      post temperatures_url, params: { temperature: { value: @temperature.value } }, as: :json
    end

    assert_response 201
  end

  test "should show temperature" do
    get temperature_url(@temperature), as: :json
    assert_response :success
  end

  test "should update temperature" do
    patch temperature_url(@temperature), params: { temperature: { value: @temperature.value } }, as: :json
    assert_response 200
  end

  test "should destroy temperature" do
    assert_difference('Temperature.count', -1) do
      delete temperature_url(@temperature), as: :json
    end

    assert_response 204
  end
end
