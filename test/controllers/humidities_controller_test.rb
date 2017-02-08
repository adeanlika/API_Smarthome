require 'test_helper'

class HumiditiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @humidity = humidities(:one)
  end

  test "should get index" do
    get humidities_url, as: :json
    assert_response :success
  end

  test "should create humidity" do
    assert_difference('Humidity.count') do
      post humidities_url, params: { humidity: { value: @humidity.value } }, as: :json
    end

    assert_response 201
  end

  test "should show humidity" do
    get humidity_url(@humidity), as: :json
    assert_response :success
  end

  test "should update humidity" do
    patch humidity_url(@humidity), params: { humidity: { value: @humidity.value } }, as: :json
    assert_response 200
  end

  test "should destroy humidity" do
    assert_difference('Humidity.count', -1) do
      delete humidity_url(@humidity), as: :json
    end

    assert_response 204
  end
end
