require 'test_helper'

class TempAlertLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @temp_alert_log = temp_alert_logs(:one)
  end

  test "should get index" do
    get temp_alert_logs_url, as: :json
    assert_response :success
  end

  test "should create temp_alert_log" do
    assert_difference('TempAlertLog.count') do
      post temp_alert_logs_url, params: { temp_alert_log: { warning: @temp_alert_log.warning } }, as: :json
    end

    assert_response 201
  end

  test "should show temp_alert_log" do
    get temp_alert_log_url(@temp_alert_log), as: :json
    assert_response :success
  end

  test "should update temp_alert_log" do
    patch temp_alert_log_url(@temp_alert_log), params: { temp_alert_log: { warning: @temp_alert_log.warning } }, as: :json
    assert_response 200
  end

  test "should destroy temp_alert_log" do
    assert_difference('TempAlertLog.count', -1) do
      delete temp_alert_log_url(@temp_alert_log), as: :json
    end

    assert_response 204
  end
end
