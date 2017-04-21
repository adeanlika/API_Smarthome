class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]
  # before_action :authenticate_user!
  # GET /devices
  def index
    @devices = Device.all

    render json: @devices
  end

  # GET /devices/1
  def show
    render json: @device
  end

  # POST /devices
  def create
    @device = Device.new(device_params)

    if @device.save
      @humidity =  Humidity.new(value:0,device_id:@device.id)
      @humidity.save
      @temperature =  Temperature.new(value:0,device_id:@device.id)
      @temperature.save
      @motion = Motion.new(value:0,device_id:@device.id)
      @motion.save
      @carbondioxide = Carbondioxide.new(value:0,device_id:@device.id)
      @carbondioxide.save
      @light = Light.new(value:0,device_id:@device.id)
      @light.save
      render json: @device, status: :created
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end
  # DELETE /devices/1
  def destroy
    @device.destroy
  end
  def test
    d = Date.today
    @energy = Energy.joins(:home).where('homes.devid = ?', params[:devid]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
    @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
    @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
    @energy_by_month = @energy_by_month.value
    render json: @energy_by_month
  end
  def get_data_sensor
      if params[:te].present?
        @temperature = Temperature.new(value: params[:te],device_id: params[:device_id])
        @temperature.save
        @lowerte = Home.where('homes.id = ?', params[:home_id]).select("lowertemp").to_a
        @lowerte = @lowerte.map {|x| x.lowertemp}
        @upperte = Home.where('homes.id = ?', params[:home_id]).select("uppertemp").to_a
        @upperte = @upperte.map {|x| x.uppertemp}
         if params[:te].to_s < @lowerte.to_s
           @alert = AlertLog.new(sensor_name: 'temperature',device_id: params[:device_id],value: params[:te],status: 'Temperature too low')
           @alert.save
          else if params[:te].to_s > @upperte.to_s
            @alert = AlertLog.new(sensor_name: 'temperature',device_id: params[:device_id],value: params[:te],status: 'Temperature too high')
            @alert.save
          end
        end
       end
      if params[:hu].present?
        @humidities = Humidity.new(value: params[:hu],device_id: params[:device_id])
        @humidities.save
        @lowerhum = Home.where('homes.id = ?', params[:home_id]).select("lowerhum").to_a
        @lowerhum = @lowerhum.map {|x| x.lowerhum}
        @upperhum = Home.where('homes.id = ?', params[:home_id]).select("upperhum").to_a
        @upperhum = @upperhum.map {|x| x.upperhum}
         if params[:hu].to_s < @lowerhum.to_s
           @alert = AlertLog.new(sensor_name: 'Humidity',device_id: params[:device_id],value: params[:hu],status: 'Humidity too low')
           @alert.save
         else if params[:hu].to_s > @upperhum.to_s
            @alert = AlertLog.new(sensor_name: 'Humidity',device_id: params[:device_id],value: params[:hu],status: 'Humidity too high')
            @alert.save
          end
        end
      end
      if params[:co2].present?
        @carbondioxides = Carbondioxide.new(value: params[:co2],device_id: params[:device_id])
        @carbondioxides.save
        @lowerco = Home.where('homes.id = ?', params[:home_id]).select("lowerco").to_a
        @lowerco = @lowerco.map {|x| x.lowerco}
        @upperco = Home.where('homes.id = ?', params[:home_id]).select("upperco").to_a
        @upperco = @upperco.map {|x| x.upperco}
         if params[:co2].to_s < @lowerco.to_s
           @alert = AlertLog.new(sensor_name: 'Carbondioxide',device_id: params[:device_id],value: params[:co],status: 'CO2 too low')
           @alert.save
         else if params[:co].to_s > @upperco.to_s
            @alert = AlertLog.new(sensor_name: 'Carbondioxide',device_id: params[:device_id],value: params[:co],status: 'CO2 too high')
            @alert.save
          end
        end
      end
      if params[:lux].present?
        @light = Light.new(value: params[:lux],device_id: params[:device_id])
        @light.save
        @lowerflux= Home.where('homes.id = ?', params[:home_id]).select("lowerflux").to_a
        @lowerflux = @lowerflux.map {|x| x.lowerflux}
        @upperflux= Home.where('homes.id = ?', params[:home_id]).select("upperflux").to_a
        @upperflux = @upperflux.map {|x| x.upperflux}
         if params[:lux].to_s < @lowerflux.to_s
           @alert = AlertLog.new(sensor_name: 'Light',device_id: params[:device_id],value: params[:co],status: 'Flux too low')
           @alert.save
         else if params[:lux].to_s > @upperflux.to_s
            @alert = AlertLog.new(sensor_name: 'Light',device_id: params[:device_id],value: params[:co],status: 'Flux too high')
            @alert.save
          end
        end
      end
      if params[:mot].present?
        @motions = Motion.new(value: params[:mot],device_id: params[:device_id])
        @motions.save

      end
    end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:home).permit(:name, :productID, :img, :home_id)
    end

end
