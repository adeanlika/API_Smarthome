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

  end
  def get_data_sensor
      if params[:te].present?
        @temperature = Temperature.new(value: params[:te],device_id: @device.id)
        if @temperature.save
          @status = 1
        @lowerte = Home.where('homes.id = ?', @device.home_id).select("lowertemp").to_a
        @lowerte = @lowerte.map {|x| x.lowertemp}
        @upperte = Home.where('homes.id = ?', @device.home_id).select("uppertemp").to_a
        @upperte = @upperte.map {|x| x.uppertemp}
         if params[:te].to_i < @lowerte.first.to_i
           @alert = AlertLog.new(sensor_name: 'temperature',device_id: @device.id,value: params[:te],status: 'Temperature too low')
           @alert.save
         else if params[:te].to_i > @upperte.first.to_i
            @alert = AlertLog.new(sensor_name: 'temperature',device_id: @device.id,value: params[:te],status: 'Temperature too high')
            @alert.save
          end

        end
      end
     end
      if params[:hu].present?
        @humidities = Humidity.new(value: params[:hu],device_id: @device.id)
      if @humidities.save
        @status = @status +1
        @lowerhum = Home.where('homes.id = ?', @device.home_id).select("lowerhum").to_a
        @lowerhum = @lowerhum.map {|x| x.lowerhum}
        @upperhum = Home.where('homes.id = ?', @device.home_id).select("upperhum").to_a
        @upperhum = @upperhum.map {|x| x.upperhum}
         if params[:hu].to_i < @lowerhum.first.to_i
           @alert = AlertLog.new(sensor_name: 'Humidity',device_id: @device.id,value: params[:hu],status: 'Humidity too low')
           @alert.save
         else if params[:hu].to_i > @upperhum.first.to_i
            @alert = AlertLog.new(sensor_name: 'Humidity',device_id: @device.id,value: params[:hu],status: 'Humidity too high')
            @alert.save
          end
        end
      end
      end
      if params[:co2].present?
        @carbondioxides = Carbondioxide.new(value: params[:co2],device_id: @device.id)
       if  @carbondioxides.save
         @status = @status + 1
        @lowerco = Home.where('homes.id = ?', @device.home_id).select("lowerco").to_a
        @lowerco = @lowerco.map {|x| x.lowerco}
        @upperco = Home.where('homes.id = ?', @device.home_id).select("upperco").to_a
        @upperco = @upperco.map {|x| x.upperco}
         if params[:co2].to_i < @lowerco.first.to_i
           @alert = AlertLog.new(sensor_name: 'Carbondioxide',device_id: @device.id,value: params[:co],status: 'CO2 too low')
           @alert.save
         else if params[:co].to_i > @upperco.first.to_i
            @alert = AlertLog.new(sensor_name: 'Carbondioxide',device_id: @device.id,value: params[:co],status: 'CO2 too high')
            @alert.save
          end
        end
        end
      end
      if params[:lux].present?
        @light = Light.new(value: params[:lux],device_id: @device.id)
        if @light.save
          @status = @status + 1
        @lowerflux= Home.where('homes.id = ?', @device.home_id).select("lowerflux").to_a
        @lowerflux = @lowerflux.map {|x| x.lowerflux}
        @upperflux= Home.where('homes.id = ?', @device.home_id).select("upperflux").to_a
        @upperflux = @upperflux.map {|x| x.upperflux}
         if params[:lux].to_i < @lowerflux.first.to_i
           @alert = AlertLog.new(sensor_name: 'Light',device_id: @device.id,value: params[:co],status: 'Flux too low')
           @alert.save
         else if params[:lux].to_i > @upperflux.first.to_i
            @alert = AlertLog.new(sensor_name: 'Light',device_id: @device.id,value: params[:co],status: 'Flux too high')
            @alert.save
          end
        end
      end
    end
      if params[:mot].present?
        @motions = Motion.new(value: params[:mot],device_id: @device.id)
        if @motions.save
          @status = @status
        end
      end
      render json: @status
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
end
