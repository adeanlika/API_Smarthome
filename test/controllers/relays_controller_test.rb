require 'test_helper'

class RelaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @relay = relays(:one)
  end

  test "should get index" do
    get relays_url, as: :json
    assert_response :success
  end

  test "should create relay" do
    assert_difference('Relay.count') do
      post relays_url, params: { relay: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show relay" do
    get relay_url(@relay), as: :json
    assert_response :success
  end

  test "should update relay" do
    patch relay_url(@relay), params: { relay: {  } }, as: :json
    assert_response 200
  end

  test "should destroy relay" do
    assert_difference('Relay.count', -1) do
      delete relay_url(@relay), as: :json
    end

    assert_response 204
  end
end
