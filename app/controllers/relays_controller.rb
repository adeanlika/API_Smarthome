class RelaysController < ApiController
  before_action :set_relay, only: [:show, :update, :destroy]
# before_action :authenticate_user!

  # GET /relays
  def index
    @relays = Device.find(params[:device_id]).relay
    render json: @relays
  end

  # GET /relays/1
  def show
    if render json: @relay
      render json: true
    else
      render json: false
    end
  end

  # POST /relays
  def create
    @relay = Relay.new(aktuator_params)


    if @relay.save
      render json: @relay, status: :created, location: @relay
    else
      render json: @relay.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /relays/1
  def update
    require 'net/http'
    require 'uri'
    if @relay.update(aktuator_params)
      @joins = Relay.joins(device: :home).where('devices.id = ? AND homes.id = ?', params[:device_id], params[:home_id])
      @gateway_id = @joins.pluck('homes.gateway_id').to_sentence
      @product_id = @joins.select("devices.product_id").map{ |h| h[:product_id]}.to_sentence
      @data = @joins.pluck(:relay1, :relay2, :relay3, :relay4, :relay5, :relay6, :relay7, :relay8, :ac_enable, :ac_power, :ac_mode, :ac_temp, :ac_speed,:ac_swing,:ac_brand).join("").gsub(/\s+/,"")
      puts @data
        url = URI.parse('http://developer.idigi.com/ws/sci')

  # Create a HTTPRequest Object based on HTTP Method.
      req = Net::HTTP::Post.new(url.path)
      # Sets The Request up for Basic Authentication.
      # Replace YourUsername and YourPassword with your username and password respectively.
      req.basic_auth 'wmustika', '$martsystem'
      # Injects XML Content into Request Body.
      req.body='<sci_request version="1.0">
        <send_message>
          <targets>
            <device id="'+@gateway_id+'"/>
          </targets>
          <rci_request version="1.1">
        <do_command target="xig">
        <send_data hw_address="'+@product_id+'">'+@data+'</send_data>
        </do_command>
        </rci_request>
        </send_message>
        </sci_request>'
          # Informs Server that the input is in XML format.
          req.set_content_type('text/xml')
          req.add_field("Accept", "text/xml")
          # Create an HTTP connection and send data to capture response.
          res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
          # Print the Response!
          puts res.body
          # Print an Error if the response was not completely successful.
          case res
          when Net::HTTPSuccess, Net::HTTPRedirection
            else
            res.error!
          end

      render json: @relay
    else
      render json: @relay.errors, status: :unprocessable_entity
    end
  end

  # DELETE /relays/1
  def destroy
    @relay.destroy
  end
  def actuator
    # require 'net/http'
    # require 'uri'


    # gateway_id = @relay.gateway_id
    # # Server that the input is in XML format.
    # #     req.Server that the input is in XML format.
    # #     req.set_coServer that the input is in XML format.
    # #     req.set_co
    # url = URI.parse('http://developer.idigi.com/ws/sci')
    #
    # # Create a HTTPRequest Object based on HTTP Method.
    # req = Net::HTTP::Post.new(url.path)
    #
    # # Sets The Request up for Basic Authentication.
    # # Replace YourUsername and YourPassword with your username and password respectively.
    # req.basic_auth 'wmustika', '$martsystem'
    # # Injects XML Content into Request Body.
    # req.body='<sci_request version="1.0">
    #   <send_message><targets>
    #   <device id="00000000-00000000-00409DFF-FF88F68B"/>
    #   </targets>
    #   <rci_request version="1.1">
    #   <do_command target="xig">
    #   <send_data hw_address="0013A20040F357C9">0000000000000000000000000000</send_data>
    #   </do_command>
    #   </rci_request>
    #   </send_message>
    #   </sci_request>'
    #     # Informs Server that the input is in XML format.
    #     req.set_content_type('text/xml')
    #     req.add_field("Accept", "text/xml")
    #     # Create an HTTP connection and send data to capture response.
    #     res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    #
    #     # Print the Response!
    #     puts res.body
    #
    #     # Print an Error if the response was not completely successful.
    #     case res
    #     when Net::HTTPSuccess, Net::HTTPRedirection
    #       #Ok
    #     else
    #       res.error!
    #     end
    render json: @relay
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relay
      @relay = Relay.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def relay_params
      params.fetch(:relay, {})
    end
    def aktuator_params
      params.permit(:relay1, :relay2, :relay3, :relay4, :relay5, :relay6, :relay7, :relay8,:relay1name,:relay2name,:relay3name,:relay4name,:relay5name,:relay6name,:relay7name,:relay8name, :ac_enable, :ac_power, :ac_mode, :ac_temp, :ac_speed, :ac_swing, :ac_brand, :device_id,:relay1icon,:relay2icon,:relay3icon,:relay4icon,:relay5icon,:relay6icon,:relay7icon,:relay8icon)
    end
end
