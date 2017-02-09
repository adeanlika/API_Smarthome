require 'test_helper'

class EnergyAlertLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @energy_alert_log = energy_alert_logs(:one)
  end

  test "should get index" do
    get energy_alert_logs_url, as: :json
    assert_response :success
  end

  test "should create energy_alert_log" do
    assert_difference('EnergyAlertLog.count') do
      post energy_alert_logs_url, params: { energy_alert_log: { warning: @energy_alert_log.warning } }, as: :json
    end

    assert_response 201
  end

  test "should show energy_alert_log" do
    get energy_alert_log_url(@energy_alert_log), as: :json
    assert_response :success
  end

  test "should update energy_alert_log" do
    patch energy_alert_log_url(@energy_alert_log), params: { energy_alert_log: { warning: @energy_alert_log.warning } }, as: :json
    assert_response 200
  end

  test "should destroy energy_alert_log" do
    assert_difference('EnergyAlertLog.count', -1) do
      delete energy_alert_log_url(@energy_alert_log), as: :json
    end

    assert_response 204
  end
end
