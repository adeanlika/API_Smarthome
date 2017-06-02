class DevicesController < ApiController
  before_action :set_device, only: [:show, :update, :destroy]
  # before_action :authenticate_user!, except: [:get_data_sensor]
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
      @relay = Relay.new(device_id: @device.id,relay1: 0,relay2: 0,relay3: 0,relay4: 0,relay5: 0,relay6: 0,relay7: 0,relay8: 0,relay1name: 'Relay 1',relay2name: 'Relay 2',relay3name: 'Relay 3',relay4name: 'Relay 4',relay5name: 'Relay 5',relay6name: 'Relay 6',relay7name: 'Relay 7',relay8name: 'Relay 8',ac_enable: 0,ac_power: 0,ac_mode: 0,ac_temp:0,ac_speed: 0,ac_swing: 0,ac_brand: 0,ac_state: 0)
      @relay.save
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
    if  @device.destroy
        render json: true
    else
      render json:false
    end
  end

  def test
    d = Date.today
    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
    @current_energy = @energy.group_by {|t| t.created_at.beginning_of_month}
    @current_energy =  @current_energy.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
    key = @current_energy.first.keys.first
    @current_energy = @current_energy.first[key]
    render json: @current_energy
  end



  def get_data_sensor
    @device = Device.find_by(product_id: params[:device_id])
    @home = @device.home
    @status = 0
      if params[:te].present?
        @temperature = Temperature.new(value: params[:te],device_id: @device.id)
        @temperature.save
        #    fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
        #    registration_ids = []
        #    @home.users.each do |u|
        #    registration_ids.push(u.fcm_token)
        #   end
        # end
        # if registration_ids.any?
        #    options = {data:{code: "UPDATE_TEMPERATURE"}}
        #    response = fcm.send(registration_ids, options)
        # end
        @status = @status + 11111111
        @lowerte = Home.where('homes.id = ?', @device.home_id).select("lowertemp").to_a
        @lowerte = @lowerte.map {|x| x.lowertemp}
        @upperte = Home.where('homes.id = ?', @device.home_id).select("uppertemp").to_a
        @upperte = @upperte.map {|x| x.uppertemp}
         if params[:te].to_i < @lowerte.first.to_i
           if @home.lowertemp_flag == false
              @alert = Alert.new(alert_type: 'Temperature',value: params[:te],status: 'Temperature too low', home_id: @home.id,device_id: @device.id)
              if @alert.save
                 @home.lowertemp_flag = true
                 @home.save
                 fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                 registration_ids = []
                 @home.users.each do |u|
                 registration_ids.push(u.fcm_token)
               end
              end
              if registration_ids.any?
                 options = {data:{code: "ALERT"}, notification: {body: "Temperature too high", title: "Temperature Warning"  }}
                 response = fcm.send(registration_ids, options)
              end
           end
         elsif params[:te].to_i > @upperte.first.to_i
           if @home.uppertemp_flag == false
              @alert = Alert.new(alert_type: 'Temperature',value: params[:te],status: 'Temperature too high',home_id: @home.id,device_id: @device.id)
              if @alert.save
                 @home.uppertemp_flag = true
                 @home.save
                 fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                 registration_ids = []
                 @home.users.each do |u|
                 registration_ids.push(u.fcm_token)
               end
              end
              if registration_ids.any?
                 options = {data:{code: "ALERT"}, notification: {body: "Temperature too low", title: "Temperature Warning"  }}
                 response = fcm.send(registration_ids, options)
              end
           end
         else
            @home.uppertemp_flag = false
            @home.save
            @home.lowertemp_flag = false
            @home.save
         end
      end
      if params[:hu].present?
        @humidities = Humidity.new(value: params[:hu],device_id: @device.id)
        @humidities.save
        #    fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
        #    registration_ids = []
        #    @home.users.each do |u|
        #    registration_ids.push(u.fcm_token)
        #   end
        # end
        # if registration_ids.any?
        #       options = {data:{code: "UPDATE_HUMIDITY"}}
        #       response = fcm.send(registration_ids, options)
        # end
        @status = @status + 11111111
        @lowerhum = Home.where('homes.id = ?', @device.home_id).select("lowerhum").to_a
        @lowerhum = @lowerhum.map {|x| x.lowerhum}
        @upperhum = Home.where('homes.id = ?', @device.home_id).select("upperhum").to_a
        @upperhum = @upperhum.map {|x| x.upperhum}
        if params[:hu].to_i < @lowerhum.first.to_i
           if @home.lowerhum_flag == false
              @alert = Alert.new(alert_type: 'Humidity',value: params[:hu],status: 'Humidity too low',home_id: @home.id,device_id: @device.id)
              if @alert.save
                 @home.lowerhum_flag = true
                 @home.save
                 fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                 registration_ids = []
                 @home.users.each do |u|
                 registration_ids.push(u.fcm_token)
               end
              end
              if registration_ids.any?
                 options = {data:{code: "ALERT"}, notification: {body: "Humidity too high", title: "Humidity Warning"  }}
                 response = fcm.send(registration_ids, options)
              end
           end
        elsif  params[:hu].to_i > @upperhum.first.to_i
           if @home.upperhum_flag == false
              @alert = Alert.new(alert_type: 'Humidity',value: params[:hu],status: 'Humidity too high',home_id: @home.id,device_id: @device.id)
              if @alert.save
                 @home.upperhum_flag = true
                 @home.save
                 fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                 registration_ids = []
                 @home.users.each do |u|
                 registration_ids.push(u.fcm_token)
               end
              end
              if registration_ids.any?
                 options = {data:{code: "ALERT"}, notification: {body: "Humidity too high", title: "Humidity Warning"  }}
                 response = fcm.send(registration_ids, options)
              end
            end
        else
          @home.upperhum_flag = false
          @home.save
          @home.lowerhum_flag = false
          @home.save
        end
      end

      if params[:co2].present?
        @carbondioxides = Carbondioxide.new(value: params[:co2],device_id: @device.id)
        @carbondioxides.save
        #    fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
        #    registration_ids = []
        #    @home.users.each do |u|
        #    registration_ids.push(u.fcm_token)
        #  end
        # end
        # if registration_ids.any?
        #    options = {data:{code: "UPDATE_CARBONDIOXIDE"}}
        #    response = fcm.send(registration_ids, options)
        # end
        @status = @status + 11111111
        @lowerco = Home.where('homes.id = ?', @device.home_id).select("lowerco").to_a
        @lowerco = @lowerco.map {|x| x.lowerco}
        @upperco = Home.where('homes.id = ?', @device.home_id).select("upperco").to_a
        @upperco = @upperco.map {|x| x.upperco}
        if params[:co2].to_i < @lowerco.first.to_i
          if @home.lowerco_flag == false
             @alert = Alert.new(alert_type: 'Carbondioxide',value: params[:co],status: 'CO2 too low',home_id: @home.id,device_id: @device.id)
             if @alert.save
                @home.lowerco_flag = true
                @home.save
                fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                registration_ids = []
                @home.users.each do |u|
                registration_ids.push(u.fcm_token)
              end
             end
             if registration_ids.any?
                options = {data:{code: "ALERT"}, notification: {body: "Carbondioxide level too high", title: "Carbondioxide Warning"  }}
                response = fcm.send(registration_ids, options)
             end
           end
         elsif  params[:co2].to_i > @upperco.first.to_i
           if @home.upperco_flag == false
              @alert = Alert.new(alert_type: 'Carbondioxide',value: params[:co],status: 'CO2 too high',home_id: @home.id,device_id: @device.id)
              if @alert.save
                 @home.upperco_flag = true
                 @home.save
                 fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                 registration_ids = []
                 @home.users.each do |u|
                 registration_ids.push(u.fcm_token)
                end
               end
               if registration_ids.any?
                  options = {data:{code: "ALERT"}, notification: {body: "Carbondioxide level too low", title: "Carbondioxide Warning"  }}
                  response = fcm.send(registration_ids, options)
               end
             end
         else
           @home.upperco_flag = false
           @home.save
           @home.lowerco_flag = false
           @home.save
         end
      end

      if params[:light].present?
        @light = Light.new(value: params[:light],device_id: @device.id)
        @light.save
        #    fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
        #    registration_ids = []
        #    @home.users.each do |u|
        #    registration_ids.push(u.fcm_token)
        #  end
        # end
        # if registration_ids.any?
        #    options = {data:{code: "UPDATE_LIGHT"}}
        #    response = fcm.send(registration_ids, options)
        # end
        @status = @status + 11111111
        @lowerflux= Home.where('homes.id = ?', @device.home_id).select("lowerflux").to_a
        @lowerflux = @lowerflux.map {|x| x.lowerflux}
        @upperflux= Home.where('homes.id = ?', @device.home_id).select("upperflux").to_a
        @upperflux = @upperflux.map {|x| x.upperflux}
        if params[:light].to_i < @lowerflux.first.to_i
          if @home.lowerflux_flag == false
             @alert = Alert.new(alert_type: 'Light',value: params[:co],status: 'Flux too low',home_id: @home.id,device_id: @device.id)
             if @alert.save
                @home.lowerflux_flag = true
                @home.save
                fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                registration_ids = []
                @home.users.each do |u|
                registration_ids.push(u.fcm_token)
              end
             end
             if registration_ids.any?
                options = {data:{code: "ALERT"}, notification: {body: "Light Intensity too high", title: "Light Intensity Warning"  }}
                response = fcm.send(registration_ids, options)
             end
          end
        elsif params[:light].to_i > @upperflux.first.to_i
          if @home.upperflux_flag == false
             @alert = Alert.new(alert_type: 'Light',value: params[:co],status: 'Flux too high',home_id: @home.id,device_id: @device.id)
             if @alert.save
                @home.upperflux_flag = true
                @home.save
                fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
                registration_ids = []
                @home.users.each do |u|
                registration_ids.push(u.fcm_token)
              end
             end
             if registration_ids.any?
                options = {data:{code: "ALERT"}, notification: {body: "Light Intensity too low", title: "Light Intensity Warning"  }}
                response = fcm.send(registration_ids, options)
             end
           end
         else
           @home.upperflux_flag = false
           @home.save
           @home.lowerflux_flag = false
           @home.save
         end
      end

      if params[:mot].present?
         @motions = Motion.new(value: params[:mot],device_id: @device.id)
         if @motions.save
            fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
            registration_ids = []
            @home.users.each do |u|
            registration_ids.push(u.fcm_token)
          end
         end
         if registration_ids.any?
            options = {data:{code: "UPDATE_SENSOR"}}
            response = fcm.send(registration_ids, options)
         end
          @status = @status + 11111111
       end

     render json: @status
  end
  def current_sensor()
    @current = Home.joins(:devices => [:humidities,:temperatures,:carbondioxides,:motions,:lights]).where('homes.id = ? AND devices.id = ?', params[:home_id],params[:device_id] ).select("humidities.value as humidity, devices.id, homes.name, temperatures.value as temperature, motions.value as motion, carbondioxides.value as CO2, lights.value as flux").last
    render json: @current
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.permit(:name, :product_id, :picture, :home_id)
    end
end
