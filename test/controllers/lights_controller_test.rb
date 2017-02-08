require 'test_helper'

class LightsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @light = lights(:one)
  end

  test "should get index" do
    get lights_url, as: :json
    assert_response :success
  end

  test "should create light" do
    assert_difference('Light.count') do
      post lights_url, params: { light: { value: @light.value } }, as: :json
    end

    assert_response 201
  end

  test "should show light" do
    get light_url(@light), as: :json
    assert_response :success
  end

  test "should update light" do
    patch light_url(@light), params: { light: { value: @light.value } }, as: :json
    assert_response 200
  end

  test "should destroy light" do
    assert_difference('Light.count', -1) do
      delete light_url(@light), as: :json
    end

    assert_response 204
  end
end
