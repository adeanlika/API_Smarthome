class CoAlertLogsController < ApplicationController
  before_action :set_co_alert_log, only: [:show, :update, :destroy]
before_action :authenticate_user!
  # GET /co_alert_logs
  def index
    @co_alert_logs = CoAlertLog.all

    render json: @co_alert_logs
  end

  # GET /co_alert_logs/1
  def show
    render json: @co_alert_log
  end

  # POST /co_alert_logs
  def create
    @co_alert_log = CoAlertLog.new(co_alert_log_params)

    if @co_alert_log.save
      render json: @co_alert_log, status: :created, location: @co_alert_log
    else
      render json: @co_alert_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /co_alert_logs/1
  def update
    if @co_alert_log.update(co_alert_log_params)
      render json: @co_alert_log
    else
      render json: @co_alert_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /co_alert_logs/1
  def destroy
    @co_alert_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_co_alert_log
      @co_alert_log = CoAlertLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def co_alert_log_params
      params.require(:co_alert_log).permit(:warning)
    end
end
