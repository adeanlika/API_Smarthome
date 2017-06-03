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
    @alert = Alert.all.order('created_at DESC')
    @alert = @alert.group_by {|t| t.created_at.beginning_of_day}
    @alert = @alert.to_a
    keys = [:date, :value]
    @alert = @alert.each.map {|value| Hash[keys.zip(value)]}
    render json: @alert
  end
  def current_notif
      @home = Home.find(params[:home_id])
      if @home.upperenergy_flag == true
        @energy = Alert.where(["alert_type = ?", "Energy"]).order('created_at ASC').last
      elsif @home.cost_limit_flag == true
        @cost = Alert.where(["alert_type = ?", "Cost"]).order('created_at ASC').last
      end
      # @current_notif = @energy.as_json.merge(@cost.as_json)
      render json: @cost
  #     elsif @home.uppertemp_flag == true
  #       @uppertemp = Alert.where('alert_type = Temperature' && 'status = Temperature too high').order('created_at ASC').last
  #     elsif @home.lowertemp_flag == true
  #
  #     elsif @home.upperhum_flag == true
  #       @upperhum = Alert.where('alert_type = Humidity' && 'status = Humidity too high').order('created_at ASC').last
  #     elsif @home.lowerhum_flag == true
  #
  #     elsif @home.upperco_flag == true
  # @uppertemp = Alert.where('alert_type = Carbondioxide' && 'status = Carbondioxide too high').order('created_at ASC').last
  #     elsif @home.lowerco_flag == true
  #
  #     elsif @home.upperflux_flag == true
  #       @uppertemp = Alert.where('alert_type = Light' && 'status = Light too high').order('created_at ASC').last
  #     elsif @home.lowerflux_flag == true



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
