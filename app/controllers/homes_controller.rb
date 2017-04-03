class HomesController < ApplicationController
  before_action :set_home, only: [:show, :update, :destroy]
  #before_action :authenticate_user!
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
    @current = Home.joins(:devices => [:humidities,:temperatures,:carbondioxides,:motions]).where('homes.id = ? AND devices.id = ?', params[:home_id],params[:device_id] ).select("humidities.value as humidity, devices.id, homes.name, temperatures.value as temperature, motions.value as motion, carbondioxides.value as CO2").last
    render json: @current
  end
  def current_energy
    d = Date.today
    @current_energy = Home.joins(:energy).where("homes.id = ?", params[:home_id]).select("energies.energy_delta, energies.created_at as date ").group_by_month('energies.created_at' , range: d.beginning_of_month..Time.now).sum("energy_delta")
    render json: @current_energy
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

end
