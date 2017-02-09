class AlertSettingsController < ApplicationController
  before_action :set_alert_setting, only: [:show, :update, :destroy]

  # GET /alert_settings
  def index
    @alert_settings = AlertSetting.all

    render json: @alert_settings
  end

  # GET /alert_settings/1
  def show
    render json: @alert_setting
  end

  # POST /alert_settings
  def create
    @alert_setting = AlertSetting.new(alert_setting_params)

    if @alert_setting.save
      render json: @alert_setting, status: :created, location: @alert_setting
    else
      render json: @alert_setting.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alert_settings/1
  def update
    if @alert_setting.update(alert_setting_params)
      render json: @alert_setting
    else
      render json: @alert_setting.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alert_settings/1
  def destroy
    @alert_setting.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert_setting
      @alert_setting = AlertSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_setting_params
      params.require(:alert_setting).permit(:value, :operation, :sensor_type)
    end
end
