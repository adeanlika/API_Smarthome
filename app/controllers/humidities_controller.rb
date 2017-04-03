class HumiditiesController < ApplicationController
#  before_action :set_humidity, only: [:show, :update, :destroy]
#  before_action :authenticate_user!
  # GET /humidities
  def index
    @humidities = Humidity.all

    render json: @humidities
  end

  # GET /humidities/1
  def show
    render json: @humidity
  end

  # POST /humidities
  def create
    @humidity = Humidity.new(humidity_params)

    if @humidity.save
      render json: @humidity, status: :created, location: @humidity
    else
      render json: @humidity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /humidities/1
  def update
    if @humidity.update(humidity_params)
      render json: @humidity
    else
      render json: @humidity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /humidities/1
  def destroy
    @humidity.destroy
  end


  def daily
    @start_date = params[:start_date].to_date.beginning_of_day
    @Humidity = Humidity.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_day('humidities.created_at', range: @start_date..Time.now).average(:value).take(6)
   #@Humidity = Humidity.all.group(:created_at).order(:created_at).average(:value)
   @Humidity = @Humidity.to_a
   keys = [:date, :value]
   @Humidity = @Humidity.each.map {|value| Hash[keys.zip(value)]}
  # @Humidity.shift
   render json: @Humidity
  end

  def weekly
  @start_date = params[:start_date].to_date.beginning_of_day
  @Humidity = Humidity.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_week('humidities.created_at', range: @start_date..Time.now).average(:value).take(6)
  @Humidity = @Humidity.to_a
  keys = [:date, :value]
  @Humidity = @Humidity.each.map {|value| Hash[keys.zip(value)]}
  #@Humidity.shift
  render json: @Humidity
  end

  def monthly
   @start_date = params[:start_date].to_date.beginning_of_day
   @Humidity = Humidity.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_month('humidities.created_at', range: @start_date..Time.now, format: "%b %Y").average(:value).take(6)
   @Humidity = @Humidity.to_a
   keys = [:date, :value]
   @Humidity = @Humidity.each.map {|value| Hash[keys.zip(value)]}
  # @Humidity.shift
   render json: @Humidity
  end

  def yearly
    @start_date = params[:start_date].to_date.beginning_of_day
    @Humidity = Humidity.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_year('humidities.created_at', range: @start_date..Time.now, format: "%Y").average(:value).take(6)
    @Humidity = @Humidity.to_a
    keys = [:date, :value]
    @Humidity = @Humidity.each.map {|value| Hash[keys.zip(value)]}
    #@Humidity.shift
    render json: @Humidity
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_humidity
      @humidity = Humidity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def humidity_params
      params.require(:humidity).permit(:value)
    end
end
