class HomesController < ApplicationController
  before_action :set_home, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:get_data_energy]
  # GET /homes
  def index
    @homes = current_user.homes.find_by(:devid)
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
      @energy = Energy.new(home_id:@home.id,cA:0,vA:0,pwr:0,energy_delta:0,total:0,tvA:0,rpA:0,pfA:0)
      @energy.save
      render json: @energy
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
    @energy = Energy.joins(:home).where('devid = ?', params[:devid]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
    @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
    @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
    # @current_energy = Home.joins(:energy).where("homes.id = ?", params[:home_id]).select("energies.energy, energies.created_at as date ").group_by_month('energies.created_at' , range: d.beginning_of_month..Time.now).sum("energy")
    key = @energy_by_month.first.keys.first

    render json: {date: key, value: @energy_by_month.first[key]}
  end
  def get_data_energy
    @energy = Energy.new(get_energy_params)
    if @energy.save
        # @lowerenergy = Home.where('devid= ?', params[:devid]).select("lowerenergy").to_a
        # @lowerenergy = @lowerenergy.map {|x| x.lowerenergy}
        # @upperenergy = Home.where('devid = ?', params[:devid]).select("upperenergy").to_a
        # @upperenergy = @upperenergy.map {|x| x.upperenergy}
        # d = Date.today
        # @energy = Energy.joins(:home).where('devid = ?', params[:devid]).select("total,energies.created_at").order('created_at ASC')
        # @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
        # @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
        # @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
        # if @energy_by_month.to_s < @lowerte.to_s
        #    @alert = AlertLog.new(sensor_name: 'temperature',device_id: params[:device_id],value: params[:te],status: 'Temperature too low')
        #    @alert.save
        #   else if params[:te].to_s > @upperte.to_s
        #     @alert = AlertLog.new(sensor_name: 'temperature',device_id: params[:device_id],value: params[:te],status: 'Temperature too high')
        #     @alert.save
        #  end
        # end
      render json: 1, status: :created # location: @energy
    else
      render json: @energy.errors,status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def home_params
      params.permit(:devid, :name, :lowertemp, :uppertemp, :lowerhum, :upperhum, :lowerco, :upperco, :lowerflux, :upperflux, :lowerenergy, :upperenergy)
    end
    def get_energy_params
      params.permit(:devid, :cA, :vA, :pwr, :energy_delta, :total, :tcA, :rpA, :pfA)
    end

end
