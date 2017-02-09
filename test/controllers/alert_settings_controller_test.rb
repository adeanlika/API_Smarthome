require 'test_helper'

class AlertSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @alert_setting = alert_settings(:one)
  end

  test "should get index" do
    get alert_settings_url, as: :json
    assert_response :success
  end

  test "should create alert_setting" do
    assert_difference('AlertSetting.count') do
      post alert_settings_url, params: { alert_setting: { operation: @alert_setting.operation, sensor_type: @alert_setting.sensor_type, value: @alert_setting.value } }, as: :json
    end

    assert_response 201
  end

  test "should show alert_setting" do
    get alert_setting_url(@alert_setting), as: :json
    assert_response :success
  end

  test "should update alert_setting" do
    patch alert_setting_url(@alert_setting), params: { alert_setting: { operation: @alert_setting.operation, sensor_type: @alert_setting.sensor_type, value: @alert_setting.value } }, as: :json
    assert_response 200
  end

  test "should destroy alert_setting" do
    assert_difference('AlertSetting.count', -1) do
      delete alert_setting_url(@alert_setting), as: :json
    end

    assert_response 204
  end
end
