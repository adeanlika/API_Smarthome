require 'test_helper'

class CoAlertLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @co_alert_log = co_alert_logs(:one)
  end

  test "should get index" do
    get co_alert_logs_url, as: :json
    assert_response :success
  end

  test "should create co_alert_log" do
    assert_difference('CoAlertLog.count') do
      post co_alert_logs_url, params: { co_alert_log: { warning: @co_alert_log.warning } }, as: :json
    end

    assert_response 201
  end

  test "should show co_alert_log" do
    get co_alert_log_url(@co_alert_log), as: :json
    assert_response :success
  end

  test "should update co_alert_log" do
    patch co_alert_log_url(@co_alert_log), params: { co_alert_log: { warning: @co_alert_log.warning } }, as: :json
    assert_response 200
  end

  test "should destroy co_alert_log" do
    assert_difference('CoAlertLog.count', -1) do
      delete co_alert_log_url(@co_alert_log), as: :json
    end

    assert_response 204
  end
end
