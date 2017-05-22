class CarbondioxidesController < ApplicationController
  before_action :set_carbondioxide, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /carbondioxides
  def index
    @carbondioxides = Carbondioxide.all

    render json: @carbondioxides
  end

  # GET /carbondioxides/1
  def show
    render json: @carbondioxide
  end

  # POST /carbondioxides
  def create
    @carbondioxide = Carbondioxide.new(carbondioxide_params)

    if @carbondioxide.save
      render json: @carbondioxide, status: :created, location: @carbondioxide
    else
      render json: @carbondioxide.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carbondioxides/1
  def update
    if @carbondioxide.update(carbondioxide_params)
      render json: @carbondioxide
    else
      render json: @carbondioxide.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carbondioxides/1
  def destroy
    @carbondioxide.destroy
  end
  def daily
    @start_date = params[:start_date].to_date.beginning_of_month
    @Carbondioxide = Carbondioxide.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_day('carbondioxides.created_at', range: @start_date..@start_date + 1.month - 1.day).average(:value)
   #@Carbondioxide = Carbondioxide.all.group(:created_at).order(:created_at).average(:value)
   @Carbondioxide = @Carbondioxide.to_a
   keys = [:date, :value]
   @Carbondioxide = @Carbondioxide.each.map {|value| Hash[keys.zip(value)]}
  # @Carbondioxide.shift
   render json: @Carbondioxide
  end

  def weekly
  @start_date = params[:start_date].to_date.beginning_of_week
  @Carbondioxide = Carbondioxide.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_week('carbondioxides.created_at', range: @start_date - 6.week..@start_date + 6.week).average(:value)
  @Carbondioxide = @Carbondioxide.to_a
  keys = [:date, :value]
  @Carbondioxide = @Carbondioxide.each.map {|value| Hash[keys.zip(value)]}
  #@Carbondioxide.shift
  render json: @Carbondioxide
  end

  def monthly
   @start_date = params[:start_date].to_date.beginning_of_year
   @Carbondioxide = Carbondioxide.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_month('carbondioxides.created_at', range: @start_date..@start_date +1.year - 1.day, format: "%b %Y").average(:value)
   @Carbondioxide = @Carbondioxide.to_a
   keys = [:date, :value]
   @Carbondioxide = @Carbondioxide.each.map {|value| Hash[keys.zip(value)]}
  # @Carbondioxide.shift
   render json: @Carbondioxide
  end

  def yearly
    @start_date = params[:start_date].to_date.beginning_of_year
    @Carbondioxide = Carbondioxide.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id]).group_by_year('carbondioxides.created_at', range: @start_date - 6.year..@start_date + 6.year, format: "%Y").average(:value)
    @Carbondioxide = @Carbondioxide.to_a
    keys = [:date, :value]
    @Carbondioxide = @Carbondioxide.each.map {|value| Hash[keys.zip(value)]}
    #@Carbondioxide.shift
    render json: @Carbondioxide
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carbondioxide
      @carbondioxide = Carbondioxide.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def carbondioxide_params
      params.permit(:value)
    end
end
