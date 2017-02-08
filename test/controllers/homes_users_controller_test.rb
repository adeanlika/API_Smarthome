require 'test_helper'

class HomesUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @homes_user = homes_users(:one)
  end

  test "should get index" do
    get homes_users_url, as: :json
    assert_response :success
  end

  test "should create homes_user" do
    assert_difference('HomesUser.count') do
      post homes_users_url, params: { homes_user: { home_id: @homes_user.home_id, user_id: @homes_user.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show homes_user" do
    get homes_user_url(@homes_user), as: :json
    assert_response :success
  end

  test "should update homes_user" do
    patch homes_user_url(@homes_user), params: { homes_user: { home_id: @homes_user.home_id, user_id: @homes_user.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy homes_user" do
    assert_difference('HomesUser.count', -1) do
      delete homes_user_url(@homes_user), as: :json
    end

    assert_response 204
  end
end
