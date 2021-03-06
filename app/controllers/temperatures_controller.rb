class TemperaturesController < ApiController
  before_action :set_temperature, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /temperatures
  def index
    @temperatures = Temperature.all

    render json: @temperatures
  end

  # GET /temperatures/1
  def show
    render json: @temperature
  end

  # POST /temperatures
  def create
    @temperature = Temperature.new(temperature_params)

    if @temperature.save
      render json: @temperature, status: :created, location: @temperature
    else
      render json: @temperature.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /temperatures/1
  def update
    if @temperature.update(temperature_params)
      render json: @temperature
    else
      render json: @temperature.errors, status: :unprocessable_entity
    end
  end

def daily
   @start_date = params[:start_date].to_date.beginning_of_month
   @Temperature = Temperature.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_day('temperatures.created_at', range: @start_date..@start_date + 1.month - 1.day).average(:value)
   @Temperature = @Temperature.to_a
   keys = [:date, :value]
   @Temperature = @Temperature.each.map {|value| Hash[keys.zip(value)]}
   #@Temperature.shift
   render json: @Temperature
  end

  def weekly
  @start_date = params[:start_date].to_date.beginning_of_week
  @Temperature = Temperature.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_week('temperatures.created_at', range: @start_date - 6.week..@start_date + 6.week).average(:value)
  @Temperature = @Temperature.to_a
   keys = [:date, :value]
   @Temperature = @Temperature.each.map {|value| Hash[keys.zip(value)]}
   #@Temperature.shift
   render json: @Temperature
  end

  def monthly
   @start_date = params[:start_date].to_date.beginning_of_year
   @Temperature = Temperature.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_month('temperatures.created_at', range: @start_date..@start_date +1.year - 1.day, format: "%b %Y").average(:value)
   @Temperature = @Temperature.to_a
   keys = [:date, :value]
   @Temperature = @Temperature.each.map {|value| Hash[keys.zip(value)]}
#   @Temperature.shift
   render json: @Temperature
  end

  def yearly
    @start_date = params[:start_date].to_date.beginning_of_year
    @Temperature = Temperature.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_year('temperatures.created_at', range: @start_date - 6.year..@start_date + 6.year, format: "%Y").average(:value)
    @Temperature = @Temperature.to_a
   keys = [:date, :value]
   @Temperature = @Temperature.each.map {|value| Hash[keys.zip(value)]}
  # @Temperature.shift
   render json: @Temperature
  end

  # DELETE /temperatures/1
  def destroy
    if @temperature.destroy
      render json: true
    else
      render json: false
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temperature
      @temperature = Temperature.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def temperature_params
      params.permit(:value)
    end
end
