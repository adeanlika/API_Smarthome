class EnergiesController < ApplicationController
  before_action :set_energy, only: [:show, :update, :destroy]
#  before_action :authenticate_user!
  # GET /energies
  def index
    @energies = Energy.all

    render json: @energies
  end

  # GET /energies/1
  def show
    render json: @energy
  end

  # POST /energies
  def create
    @energy = Energy.new(energy_params)

    if @energy.save
      render json: @energy, status: :created, location: @energy
    else
      render json: @energy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /energies/1
  def update
    if @energy.update(energy_params)
      render json: @energy
    else
      render json: @energy.errors, status: :unprocessable_entity
    end
  end

  # DELETE /energies/1
  def destroy
    @energy.destroy
  end

  def daily
  #@energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  #@energy = Energy.select("date_trunc( 'day', created_at ) as day, sum(energy_delta) as total_energy").group('day').take(6).order(created_at: :desc)
@start_date = params[:start_date].to_date.beginning_of_day
#  @energy = Energy.group_by{|energy_delta| energy.created_at.day}
@energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).group_by_day('energies.created_at', range: @start_date..Time.now).sum("energy_delta").take(6)
@energy = @energy.to_a
 keys = [:date, :total]
@energy = @energy.each.map {|energy_delta| Hash[keys.zip(energy_delta)]}
  #  @energy = @energy.group_by { |t| t.created_at.beginning_of_month }
    #  @start_date = params[:start_date].to_date.beginning_of_day
    #   @energy = Energy.all.group_by_day(:created_at, range: @start_date..Time.now).take(6)
    # # orders = Energy.group("date(created_at)")
    # orders = Energy.select("date(created_at), sum(power) as total_amount")
    # orders =  orders.group_by { |order| order.created_at.to_date }
#  @start_date = params[:start_date].to_date.beginning_of_day

#  @energy = Energy.group_by_day(:created_at, range: @start_date..Time.now).take(6)
#@energy = @energy.to_a
#keys = [:date, :total_energy]
#@energy = @energy.first - @energy.last
#   @energy = @energy.each.map {|value| Hash[keys.zip(value)]}
render json: @energy
  end

  def monthly
  # @energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  # @energy = Energy.select("date_trunc( 'month', created_at ) as month, sum(energy_delta) as total_energy").group('month').take(6)
  @start_date = params[:start_date].to_date.beginning_of_day
  #  @energy = Energy.group_by{|energy_delta| energy.created_at.day}
   @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).group_by_month('energies.created_at', range: @start_date..Time.now, format: "%b %Y").sum("energy_delta").take(6)
  @energy = @energy.to_a
  keys = [:date, :total]
  @energy = @energy.each.map {|energy_delta| Hash[keys.zip(energy_delta)]}

  render json: @energy
  end

  def yearly
  # @energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  # @energy = Energy.select("date_trunc( 'year', created_at ) as year, sum(energy_delta) as total_energy").group('year').take(6)
  # render json: @energy
  @start_date = params[:start_date].to_date.beginning_of_day
 #  @energy = Energy.group_by{|energy_delta| energy.created_at.day}
   @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).group_by_year('energies.created_at', range: @start_date..Time.now, format: "%Y").sum("energy_delta").take(6)
  @energy = @energy.to_a
  keys = [:date, :total]
 @energy = @energy.each.map {|energy_delta| Hash[keys.zip(energy_delta)]}
 render json: @energy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy
      @energy = Energy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_params
    params.require(:energy).permit(:devid, :cA, :vA, :pwr, :energy_delta, :total, :tvA, :rpA, :pfA, :home_id)
    end



end
