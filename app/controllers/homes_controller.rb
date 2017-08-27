class HomesController < ApiController
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
      @homesuser = HomesUser.new(home_id:@home.id,user_id:current_user.id,is_admin:true)
      @homesuser.save
      @energy = Energy.new(home_id:@home.id,cA:0,vA:0,pwr:0,energy_delta:0,total:0,tcA:0,rpA:0,pfA:0)
      @energy.save
      render json: @home
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
  if current_user.valid_password?(params[:password])
    if @home.destroy
       render json: true
    else
      render json:false
    end
  else
    render json:false
  end
end
def set_energy_limit
  @home = Home.find(params[:home_id])
  if params[:energy_limit].present?
    @cost_limit = (params[:energy_limit].to_f * @home.electricity_price)
    @home.update(upperenergy: params[:energy_limit],cost_limit: @cost_limit)
    @home.save
    render json: @home
  elsif params[:cost_limit].present?
    @energy_limit = (params[:cost_limit].to_f / @home.electricity_price)
    @home.update(upperenergy: @energy_limit, cost_limit: params[:cost_limit])
    @home.save
    render json: @home
  else
    render json: @home
  end

end

def set_supply
  @home = Home.find(params[:home_id])
  if params[:supply].present?
    @home.update(supply: params[:supply])
    if @supply == 1300
       @home.update(electricity_price: 1467.28)
       @home.save
    elsif @supply == 2200
       @home.update(electricity_price: 1467.28)
       @home.save
    elsif @supply == 3500
       @home.update(electricity_price: 1467.28)
       @home.save
    elsif @supply == 5500
       @home.update(electricity_price: 1467.28)
       @home.save
    elsif @supply == 6600
       @home.update(electricity_price: 1467.28)
       @home.save
    end
  end
    render json: @home
end

  # def current()
  #   @current = Home.joins(:devices => [:humidities,:temperatures,:carbondioxides,:motions,:lights]).where('homes.id = ? AND devices.id = ?', params[:home_id],params[:device_id] ).select("humidities.value as humidity, devices.id, homes.name, temperatures.value as temperature, motions.value as motion, carbondioxides.value as CO2, lights.value as flux").last
  #   render json: @current
  # end
  # def current_energy
  #   d = Date.today
  #   @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
  #   @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
  #   @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
  #   @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
  #   @energy_by_month = @energy_by_month.map do |g|
  #           k, v = g.first
  #           { "date"=> k.to_s, "value"=>v }
  #           end
  #   # key = @energy_by_month.first.keys.first
  #   @energy_by_month = @energy_by_month.reduce Hash.new, :merge
  #   @temannya = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select(:cA,:pwr,:vA).last
  #   @energy_by_month = @energy_by_month.reverse_merge(@temannya.as_json)
  #   render json: @energy_by_month
  #   # new[date: key, value: @energy_by_month.first[key]]
  # end
  #
  # def presentase
  #   d = Date.today
  #   @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
  #   @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
  #   @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
  #   @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
  #   @energy_by_month = @energy_by_month.first.values
  #   @upperenergy = Home.where('homes.id = ?', params[:home_id]).select("upperenergy").map{ |h| h[:upperenergy]}.to_a
  #   @presentase = (@energy_by_month.first / @upperenergy.first)*100
  #   render json: @presentase
  # end
  #
  #
  # def get_cost(home_id)
  #   d = Date.today
  #   @energy = Energy.joins(:home).where('homes.id = ?', home_id).select("total,energies.created_at").order('created_at ASC')
  #   @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
  #   @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
  #   @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
  #   @energy_by_month = @energy_by_month.first.values
  #   @supply = supply_value(params[:home_id])
  #   @cost = (@energy_by_month.first * @supply)/1000
  #   return @cost
  # end
  #
  # def cost
  #   render json: get_cost(params[:home_id])
  # end
  #


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = current_user.homes.find(params[:id])
      raise ActiveRecord::RecordNotFound unless @home
    end

    # Only allow a trusted parameter "white list" through.
    def home_params
      params.permit(:devid, :name, :lowertemp, :uppertemp, :lowerhum, :upperhum, :lowerco, :upperco, :lowerflux, :upperflux, :upperenergy,:cost_limit, :supply, :gateway_id,:electricity_price)
    end
    def get_energy_params
      params.permit(:devid, :cA, :vA, :pwr, :energy_delta, :total, :tcA, :rpA, :pfA)
    end

end
