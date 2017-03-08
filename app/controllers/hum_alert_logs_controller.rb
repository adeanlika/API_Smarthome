class HumAlertLogsController < ApplicationController
  before_action :set_hum_alert_log, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /hum_alert_logs
  def index
    @hum_alert_logs = HumAlertLog.all

    render json: @hum_alert_logs
  end

  # GET /hum_alert_logs/1
  def show
    render json: @hum_alert_log
  end

  # POST /hum_alert_logs
  def create
    @hum_alert_log = HumAlertLog.new(hum_alert_log_params)

    if @hum_alert_log.save
      render json: @hum_alert_log, status: :created, location: @hum_alert_log
    else
      render json: @hum_alert_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hum_alert_logs/1
  def update
    if @hum_alert_log.update(hum_alert_log_params)
      render json: @hum_alert_log
    else
      render json: @hum_alert_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hum_alert_logs/1
  def destroy
    @hum_alert_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hum_alert_log
      @hum_alert_log = HumAlertLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hum_alert_log_params
      params.require(:hum_alert_log).permit(:warning)
    end
end
