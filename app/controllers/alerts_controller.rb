class AlertsController < ApiController
  before_action :set_alert, only: [:show, :update, :destroy]

  # GET /energy_alert_logs
  def index
    @alerts = Alert.all
    render json: @alerts
  end

  # GET /energy_alert_logs/1
  def show
    render json: @alert
  end

  # POST /energy_alert_logs
  def create
    @alert = Alert.new(alert_params)

    if @alert.save
      render json: @alert, status: :created, location: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /energy_alert_logs/1
  def update
    if @alert.update(alert_params)
      render json: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # DELETE /energy_alert_logs/1
  def destroy
  if  @alert.destroy
    render json: true
  else
    render json: false
  end
  end
  def alert_by_date
    @alert = Alert.all
    @alert = @alert.group_by {|t| t.created_at.beginning_of_day}
    render json: @alert
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.permit(:alert_type,:value,:status)
    end
end
