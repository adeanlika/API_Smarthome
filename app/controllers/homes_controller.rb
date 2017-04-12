class HomesController < ApplicationController
  before_action :set_home, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /homes
  def index
    @homes = current_user.homes

    render json: @homes
  end

  # GET /homes/1
  def show
    render json: @home
  end

  # POST /homes
  def create
    @home = Home.new(home_params)

    if @home.save
      render json: @home, status: :created, location: @home
    else
      render json: @home.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /homes/1
  def update
    if @home.update(home_params)
      render json: @home
    else
      render json: @home.errors, status: :unprocessable_entity
    end
  end

  # DELETE /homes/1
  def destroy
    @home.destroy
  end
  def current()
    @current = Home.joins(:devices => [:humidities,:temperatures,:carbondioxides,:motions,:lights]).where('homes.id = ? AND devices.id = ?', params[:home_id],params[:device_id] ).select("humidities.value as humidity, devices.id, homes.name, temperatures.value as temperature, motions.value as motion, carbondioxides.value as CO2, lights.value as flux").last
    render json: @current
  end
  def current_energy
    d = Date.today
    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
    @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
    @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
    # @current_energy = Home.joins(:energy).where("homes.id = ?", params[:home_id]).select("energies.energy, energies.created_at as date ").group_by_month('energies.created_at' , range: d.beginning_of_month..Time.now).sum("energy")
    key = @energy_by_month.first.keys.first

    render json: {date: key, value: @energy_by_month.first[key]}
  end
  def get_data_energy
    @energy = Energy.new(get_data_params)
    if @energy.save
      render json: @energy, status: :created # location: @energy
    else
      render json: @energy.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def home_params
      params.require(:home).permit(:name, :sensor, :max, :min)
    end
    def get_data_params
      params.permit(:devid, :cA, :vA, :pwr, :energy_delta, :total, :tvA, :rpA, :pfA, :home_id)
    end

end
