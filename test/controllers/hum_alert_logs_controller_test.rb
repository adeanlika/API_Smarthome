require 'test_helper'

class HumAlertLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hum_alert_log = hum_alert_logs(:one)
  end

  test "should get index" do
    get hum_alert_logs_url, as: :json
    assert_response :success
  end

  test "should create hum_alert_log" do
    assert_difference('HumAlertLog.count') do
      post hum_alert_logs_url, params: { hum_alert_log: { warning: @hum_alert_log.warning } }, as: :json
    end

    assert_response 201
  end

  test "should show hum_alert_log" do
    get hum_alert_log_url(@hum_alert_log), as: :json
    assert_response :success
  end

  test "should update hum_alert_log" do
    patch hum_alert_log_url(@hum_alert_log), params: { hum_alert_log: { warning: @hum_alert_log.warning } }, as: :json
    assert_response 200
  end

  test "should destroy hum_alert_log" do
    assert_difference('HumAlertLog.count', -1) do
      delete hum_alert_log_url(@hum_alert_log), as: :json
    end

    assert_response 204
  end
end
