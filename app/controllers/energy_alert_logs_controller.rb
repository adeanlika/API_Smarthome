class EnergyAlertLogsController < ApplicationController
  before_action :set_energy_alert_log, only: [:show, :update, :destroy]

  # GET /energy_alert_logs
  def index
    @energy_alert_logs = EnergyAlertLog.all

    render json: @energy_alert_logs
  end

  # GET /energy_alert_logs/1
  def show
    render json: @energy_alert_log
  end

  # POST /energy_alert_logs
  def create
    @energy_alert_log = EnergyAlertLog.new(energy_alert_log_params)

    if @energy_alert_log.save
      render json: @energy_alert_log, status: :created, location: @energy_alert_log
    else
      render json: @energy_alert_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /energy_alert_logs/1
  def update
    if @energy_alert_log.update(energy_alert_log_params)
      render json: @energy_alert_log
    else
      render json: @energy_alert_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /energy_alert_logs/1
  def destroy
    @energy_alert_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy_alert_log
      @energy_alert_log = EnergyAlertLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_alert_log_params
      params.permit(:home_name,:value,:status)
    end
end
