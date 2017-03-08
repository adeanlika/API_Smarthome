require 'test_helper'

class CarbondioxidesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @carbondioxide = carbondioxides(:one)
  end

  test "should get index" do
    get carbondioxides_url, as: :json
    assert_response :success
  end

  test "should create carbondioxide" do
    assert_difference('Carbondioxide.count') do
      post carbondioxides_url, params: { carbondioxide: { value: @carbondioxide.value } }, as: :json
    end

    assert_response 201
  end

  test "should show carbondioxide" do
    get carbondioxide_url(@carbondioxide), as: :json
    assert_response :success
  end

  test "should update carbondioxide" do
    patch carbondioxide_url(@carbondioxide), params: { carbondioxide: { value: @carbondioxide.value } }, as: :json
    assert_response 200
  end

  test "should destroy carbondioxide" do
    assert_difference('Carbondioxide.count', -1) do
      delete carbondioxide_url(@carbondioxide), as: :json
    end

    assert_response 204
  end
end
