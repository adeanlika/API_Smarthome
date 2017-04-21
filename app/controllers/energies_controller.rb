class EnergiesController < ApplicationController
  before_action :set_energy, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:get_data_energy]
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
  def get_data_energy
    @energy = Energy.new(energy_params)
    @home = Home.find_by(devid: params[:devid])
    @energy.home_id = @home.id
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
      render json: 0,status: :unprocessable_entity
    end
  end

  def daily
  #@energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  #@energy = Energy.select("date_trunc( 'day', created_at ) as day, sum(energy_delta) as total_energy").group('day').take(6).order(created_at: :desc)
  @start_date = params[:start_date].to_date.beginning_of_day
  @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
  @energy = @energy.where(:created_at => @start_date..Time.now)
  @energy_by_day = @energy.group_by {|t| t.created_at.beginning_of_day}
  @energy_by_day =  @energy_by_day.collect { |day, total| { day => total.last[:total] - total.first[:total] } }.take(6)
  @energy_by_day = @energy_by_day.map do |g|
          k, v = g.first
          { "date"=> k.to_s, "value"=>v }
          end
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
render json: @energy_by_day
  end

  def weekly
    @start_date = params[:start_date].to_date.beginning_of_day
    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => @start_date..Time.now)
    @energy_by_week = @energy.group_by {|t| t.created_at.beginning_of_week}
    @energy_by_week =  @energy_by_week.collect { |week, total| { week => total.last[:total] - total.first[:total] } }.take(6)
    @energy_by_week = @energy_by_week.map do |g|
            k, v = g.first
            { "date"=> k.to_s, "value"=>v }
            end
    render json: @energy_by_week
  end


  def monthly
    @start_date = params[:start_date].to_date.beginning_of_day
    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => @start_date..Time.now)
    @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
    @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }.take(6)


    #  @energy_by_month = @energy_by_month.to_a
    # @start_date = params[:start_date].to_date.beginning_of_day
    # @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).group_by_month('energies.created_at', range: @start_date..Time.now, format: "%b %Y")
    # @energy_by_month.each do |month, readings|
    #         sorted_readings = readings.sort_by{ |reading| reading[:created_at] }
    #         first_value = sorted_readings.first[:energy_delta]
    #         last_value  = sorted_readings.last[:energy_delta]
    #         last_value - first_value
    #       end
    # keys = [:date, :total]
    # @energy = @energy.each.map {|energy_delta| Hash[keys.zip(energy_delta)]}
    # @energy = @energy_by_mon.each.map {|g,v| Hash[g[:dates], [g[:total]]]}
    @energy_by_month = @energy_by_month.map do |g|
            k, v = g.first
            { "date"=> k.to_s, "value"=>v }
            end#.map {|h| Hash[%w(date value).zip(h.keys + h.values)]}

    render json: @energy_by_month


    #  render json: @energy_by_month




  # @energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  # @energy = Energy.select("date_trunc( 'month', created_at ) as month, sum(energy_delta) as total_energy").group('month').take(6)
  # @energy = Energy.group_by{|energy_delta| energy.created_at.day}

  # @start_date = params[:start_date].to_date.beginning_of_day
  # @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).group_by_month('energies.created_at', range: @start_date..Time.now, format: "%b %Y")#.sum("energy_delta").take(6)
  # @energy = @energy.to_a
  # keys = [:date, :total]
  # @energy = @energy.each.map {|energy_delta| Hash[keys.zip(energy_delta)]}
  #
  #   render json:  @energy
  end

  def yearly

  # @energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  # @energy = Energy.select("date_trunc( 'year', created_at ) as year, sum(energy_delta) as total_energy").group('year').take(6)
  # render json: @energy
  #  @energy = Energy.group_by{|energy_delta| energy.created_at.day}


    @start_date = params[:start_date].to_date.beginning_of_day
    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => @start_date..Time.now)
    @energy_by_year = @energy.group_by {|t| t.created_at.beginning_of_year}
    @energy_by_year =  @energy_by_year.collect { |year, total| { year => total.last[:total] - total.first[:total] } }.take(6)
    @energy_by_year = @energy_by_year.map do |g|
            k, v = g.first
            { "date"=> k.to_s, "value"=>v }
            end
    # @energy = @energy.to_a
    # keys = [:date, :total]
    # @energy = @energy.each.map {|energy_delta| Hash[keys.zip(energy_delta)]}
    render json: @energy_by_year
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy
      @energy = Energy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_params
    params.permit(:devid, :cA, :vA, :pwr, :energy_delta, :total, :tvA, :rpA, :pfA)
    end
end
