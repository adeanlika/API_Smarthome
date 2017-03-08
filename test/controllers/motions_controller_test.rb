require 'test_helper'

class MotionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @motion = motions(:one)
  end

  test "should get index" do
    get motions_url, as: :json
    assert_response :success
  end

  test "should create motion" do
    assert_difference('Motion.count') do
      post motions_url, params: { motion: { value: @motion.value } }, as: :json
    end

    assert_response 201
  end

  test "should show motion" do
    get motion_url(@motion), as: :json
    assert_response :success
  end

  test "should update motion" do
    patch motion_url(@motion), params: { motion: { value: @motion.value } }, as: :json
    assert_response 200
  end

  test "should destroy motion" do
    assert_difference('Motion.count', -1) do
      delete motion_url(@motion), as: :json
    end

    assert_response 204
  end
end
