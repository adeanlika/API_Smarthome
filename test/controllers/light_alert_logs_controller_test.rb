require 'test_helper'

class LightAlertLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @light_alert_log = light_alert_logs(:one)
  end

  test "should get index" do
    get light_alert_logs_url, as: :json
    assert_response :success
  end

  test "should create light_alert_log" do
    assert_difference('LightAlertLog.count') do
      post light_alert_logs_url, params: { light_alert_log: { warning: @light_alert_log.warning } }, as: :json
    end

    assert_response 201
  end

  test "should show light_alert_log" do
    get light_alert_log_url(@light_alert_log), as: :json
    assert_response :success
  end

  test "should update light_alert_log" do
    patch light_alert_log_url(@light_alert_log), params: { light_alert_log: { warning: @light_alert_log.warning } }, as: :json
    assert_response 200
  end

  test "should destroy light_alert_log" do
    assert_difference('LightAlertLog.count', -1) do
      delete light_alert_log_url(@light_alert_log), as: :json
    end

    assert_response 204
  end
end
