require 'test_helper'

class MotionAlertLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @motion_alert_log = motion_alert_logs(:one)
  end

  test "should get index" do
    get motion_alert_logs_url, as: :json
    assert_response :success
  end

  test "should create motion_alert_log" do
    assert_difference('MotionAlertLog.count') do
      post motion_alert_logs_url, params: { motion_alert_log: { warning: @motion_alert_log.warning } }, as: :json
    end

    assert_response 201
  end

  test "should show motion_alert_log" do
    get motion_alert_log_url(@motion_alert_log), as: :json
    assert_response :success
  end

  test "should update motion_alert_log" do
    patch motion_alert_log_url(@motion_alert_log), params: { motion_alert_log: { warning: @motion_alert_log.warning } }, as: :json
    assert_response 200
  end

  test "should destroy motion_alert_log" do
    assert_difference('MotionAlertLog.count', -1) do
      delete motion_alert_log_url(@motion_alert_log), as: :json
    end

    assert_response 204
  end
end
