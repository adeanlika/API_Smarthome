class LightsController < ApplicationController
  before_action :set_light, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  #ET /lights
  def index
    @lights = Light.all

    render json: @lights
  end

  # GET /lights/1
  def show
    render json: @light
  end

  # POST /lights
  def create
    @light = Light.new(light_params)

    if @light.save
      render json: @light, status: :created, location: @light
    else
      render json: @light.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lights/1
  def update
    if @light.update(light_params)
      render json: @light
    else
      render json: @light.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lights/1
  def destroy
    @light.destroy
  end
  def daily
    @start_date = params[:start_date].to_date.beginning_of_day
    @Light= Light.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_day('lights.created_at', range: @start_date..Time.now).average(:value).take(6)
   #@Humidity = Humidity.all.group(:created_at).order(:created_at).average(:value)
   @Light = @Light.to_a
   keys = [:date, :value]
   @Light = @Light.each.map {|value| Hash[keys.zip(value)]}
  # @Humidity.shift
   render json: @Light
  end

  def weekly
  @start_date = params[:start_date].to_date.beginning_of_day
  @Light = Light.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_week('lights.created_at', range: @start_date..Time.now).average(:value).take(6)
  @Light = @Light.to_a
  keys = [:date, :value]
  @Light = @Light.each.map {|value| Hash[keys.zip(value)]}
  #@Humidity.shift
  render json: @Light
  end

  def monthly
   @start_date = params[:start_date].to_date.beginning_of_day
   @Light = Light.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_month('lights.created_at', range: @start_date..Time.now, format: "%b %Y").average(:value).take(6)
   @Light = @Light.to_a
   keys = [:date, :value]
   @Light = @Light.each.map {|value| Hash[keys.zip(value)]}
  # @Humidity.shift
   render json: @Light
  end

  def yearly
    @start_date = params[:start_date].to_date.beginning_of_day
    @Light = Light.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_year('lights.created_at', range: @start_date..Time.now, format: "%Y").average(:value).take(6)
    @Light = @Light.to_a
    keys = [:date, :value]
    @Light = @Light.each.map {|value| Hash[keys.zip(value)]}
    #@Humidity.shift
    render json: @Light
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light
      @light = Light.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def light_params
      params.require(:light).permit(:value)
    end
end
