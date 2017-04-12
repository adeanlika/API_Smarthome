class AlertLogsController < ApplicationController
  before_action :set_alert_log, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /alert_logs
  def index
    @alert_logs = AlertLog.all

    render json: @alert_logs
  end

  # GET /alert_logs/1
  def show
    render json: @alert_log
  end

  # POST /alert_logs
  def create
    @alert_log = AlertLog.new(alert_log_params)

    if @alert_log.save
      render json: @alert_log, status: :created, location: @alert_log
    else
      render json: @alert_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alert_logs/1
  def update
    if @alert_log.update(alert_log_params)
      render json: @alert_log
    else
      render json: @alert_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alert_logs/1
  def destroy
    @alert_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert_log
      @alert_log = AlertLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_log_params
      params.require(:alert_log).permit(:sensor_name, :value, :status)
    end
end
