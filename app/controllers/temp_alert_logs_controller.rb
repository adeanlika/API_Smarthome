class TempAlertLogsController < ApplicationController
  before_action :set_temp_alert_log, only: [:show, :update, :destroy]

  # GET /temp_alert_logs
  def index
    @temp_alert_logs = TempAlertLog.all

    render json: @temp_alert_logs
  end

  # GET /temp_alert_logs/1
  def show
    render json: @temp_alert_log
  end

  # POST /temp_alert_logs
  def create
    @temp_alert_log = TempAlertLog.new(temp_alert_log_params)

    if @temp_alert_log.save
      render json: @temp_alert_log, status: :created, location: @temp_alert_log
    else
      render json: @temp_alert_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /temp_alert_logs/1
  def update
    if @temp_alert_log.update(temp_alert_log_params)
      render json: @temp_alert_log
    else
      render json: @temp_alert_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /temp_alert_logs/1
  def destroy
    @temp_alert_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_alert_log
      @temp_alert_log = TempAlertLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def temp_alert_log_params
      params.require(:temp_alert_log).permit(:warning)
    end
end
