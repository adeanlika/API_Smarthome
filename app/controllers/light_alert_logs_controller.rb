class LightAlertLogsController < ApplicationController
  before_action :set_light_alert_log, only: [:show, :update, :destroy]

  # GET /light_alert_logs
  def index
    @light_alert_logs = LightAlertLog.all

    render json: @light_alert_logs
  end

  # GET /light_alert_logs/1
  def show
    render json: @light_alert_log
  end

  # POST /light_alert_logs
  def create
    @light_alert_log = LightAlertLog.new(light_alert_log_params)

    if @light_alert_log.save
      render json: @light_alert_log, status: :created, location: @light_alert_log
    else
      render json: @light_alert_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /light_alert_logs/1
  def update
    if @light_alert_log.update(light_alert_log_params)
      render json: @light_alert_log
    else
      render json: @light_alert_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /light_alert_logs/1
  def destroy
    @light_alert_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light_alert_log
      @light_alert_log = LightAlertLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def light_alert_log_params
      params.require(:light_alert_log).permit(:warning)
    end
end
