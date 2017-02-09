class MotionAlertLogsController < ApplicationController
  before_action :set_motion_alert_log, only: [:show, :update, :destroy]

  # GET /motion_alert_logs
  def index
    @motion_alert_logs = MotionAlertLog.all

    render json: @motion_alert_logs
  end

  # GET /motion_alert_logs/1
  def show
    render json: @motion_alert_log
  end

  # POST /motion_alert_logs
  def create
    @motion_alert_log = MotionAlertLog.new(motion_alert_log_params)

    if @motion_alert_log.save
      render json: @motion_alert_log, status: :created, location: @motion_alert_log
    else
      render json: @motion_alert_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /motion_alert_logs/1
  def update
    if @motion_alert_log.update(motion_alert_log_params)
      render json: @motion_alert_log
    else
      render json: @motion_alert_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /motion_alert_logs/1
  def destroy
    @motion_alert_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motion_alert_log
      @motion_alert_log = MotionAlertLog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def motion_alert_log_params
      params.require(:motion_alert_log).permit(:warning)
    end
end
