require 'test_helper'

class AlertLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alert_log = alert_logs(:one)
  end

  test "should get index" do
    get alert_logs_url, as: :json
    assert_response :success
  end

  test "should create alert_log" do
    assert_difference('AlertLog.count') do
      post alert_logs_url, params: { alert_log: { sensor_name: @alert_log.sensor_name, status: @alert_log.status, value: @alert_log.value } }, as: :json
    end

    assert_response 201
  end

  test "should show alert_log" do
    get alert_log_url(@alert_log), as: :json
    assert_response :success
  end

  test "should update alert_log" do
    patch alert_log_url(@alert_log), params: { alert_log: { sensor_name: @alert_log.sensor_name, status: @alert_log.status, value: @alert_log.value } }, as: :json
    assert_response 200
  end

  test "should destroy alert_log" do
    assert_difference('AlertLog.count', -1) do
      delete alert_log_url(@alert_log), as: :json
    end

    assert_response 204
  end
end
