class EnergiesController < ApiController
  before_action :set_energy, only: [:show, :update, :destroy]
  # before_action :authenticate_user!, except: [:get_data_energy]
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
    if @energy.destroy
      render json: true
    else
      render json: false
    end
  end

  def get_data_energy
    @energy = Energy.new(energy_params)
    @home = Home.find_by(devid: params[:devid])
    @energy.home_id = @home.id
    if @energy.save
      fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
      registration_ids = []
      @home.users.each do |u|
        registration_ids.push(u.fcm_token)
      end
      if registration_ids.any?
        options = {data:{code: "UPDATE_ENERGY"}}
        response = fcm.send(registration_ids, options)
      end
      @status = 1
      d = Date.today
      @energy_status = get_current_energy(@home.id)
      key = @energy_status.first.keys.first
      @energy_status = @energy_status.first[key]
      @upperenergy = Home.where('homes.id = ?',  @home.id).select("upperenergy").to_a
      @upperenergy = @upperenergy.map {|x| x.upperenergy}
        if @energy_status > @upperenergy.first
          if @home.upperenergy_flag == false
            @energy_alert = Alert.new(alert_type: 'Energy',value: @energy_status,status: 'Energy too high',home_id: @home.id)
            if @energy_alert.save
              fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
              registration_ids = []
              @home.users.each do |u|
                registration_ids.push(u.fcm_token)
              end
              if registration_ids.any?
                options = {data:{code: "ALERT"}, notification: {body: "Energy too high", title: "Energy Warning"  }}

                response = fcm.send(registration_ids, options)
              end
              @status = @status + 1
              @home.upperenergy_flag = true;
              @home.save;
            end

          end
        else @energy_status < @upperenergy.first
          @home.upperenergy_flag = false;
          @home.save;
        end
        @current_cost = get_cost(@home.id)
        @cost_limit = @home.cost_limit
        if @current_cost > @cost_limit
          if @home.cost_limit_flag == false
            @cost_alert = Alert.new(alert_type: 'Cost',value: @current_cost,status: 'Cost exceeds limit',home_id: @home.id)
            if @cost_alert.save
              fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
              registration_ids = []
              @home.users.each do |u|
                registration_ids.push(u.fcm_token)
              end
              if registration_ids.any?
                options = {data:{code: "ALERT"}, notification: {body: "Cost exceeds limit", title: "Cost Warning"  }}

                response = fcm.send(registration_ids, options)
              end
              @status = @status + 1
              @home.cost_limit_flag = true;
              @home.save;
            end
          end
        else @current_cost < @cost_limit
          @home.cost_limit_flag = false;
          @home.save;
        end
    else
      @status = 0
    end
    render json: @current_cost
  end

  def supply(home_id)
    @home = Home.find(home_id)
    @supply = @home.supply
    if @supply = 1300
      @supply = 1467.28
    elsif @supply = 2200
      @supply = 1467.28
    elsif @supply = 3500
      @supply = 1467.28
    elsif @supply = 5500
      @supply = 1467.28
    elsif @supply = 6600
      @supply = 1467.28
    end
    return @supply
  end

  def get_current_energy(home_id)
    Time.zone ="Bangkok"
    d = Date.today
    @energy = Energy.joins(:home).where('homes.id = ?', home_id).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => d.beginning_of_month.in_time_zone("Bangkok")..Time.now)
    @current_energy = @energy.group_by {|t| t.created_at.beginning_of_month}
    @current_energy =  @current_energy.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
    return @current_energy
  end
  def current_energy
    @energy_status = get_current_energy(params[:home_id])
    @energy_status= @energy_status.map do |g|
            k, v = g.first
            { "date"=> k.to_s, "value"=>v }
            end
    # key = @energy_by_month.first.keys.first
    @energy_status = @energy_status.reduce Hash.new, :merge
    @all_status = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select(:cA,:pwr,:vA).last
    @energy_status = @energy_status.reverse_merge(@all_status.as_json)
    render json: @energy_status
    # new[date: key, value: @energy_by_month.first[key]]
  end

  def presentase
    d = Date.today
    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where(:created_at => d.beginning_of_month..Time.now)
    @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
    @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
    @energy_by_month = @energy_by_month.first.values
    @upperenergy = Home.where('homes.id = ?', params[:home_id]).select("upperenergy").map{ |h| h[:upperenergy]}.to_a
    @presentase = (@energy_by_month.first / @upperenergy.first)*100
    render json: @presentase
  end


  def get_cost(home_id)
    # Time.zone = "Bangkok"
    # d = Date.today
    # @energy = Energy.joins(:home).where('homes.id = ?', home_id).select("total,energies.created_at").order('created_at ASC')
    # @energy = @energy.where(:created_at => d.beginning_of_month.in_time_zone("Bangkok")..Time.now)
    # @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
    # @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }
    # @energy_by_month = @energy_by_month.first.values

    @current = get_current_energy(home_id)
    @supply = supply(home_id)
    @cost = (@current.first.values.first * @supply)/1000
    return @cost
  end

  def cost
    render json: get_cost(params[:home_id])
  end


  def get_daily(start_date)
    # koding versi baruww
    Time.zone = "Bangkok"
    @count = Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_day('energies.created_at', range: start_date..start_date + 1.month - 1.day).count(:total)
    @count = @count.collect {|ind| ind[1]}

    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where('energies.created_at' => start_date.in_time_zone("Bangkok")..start_date + 1.month - 1.day).group_by{|t| t.created_at.beginning_of_day}
    if not @energy.empty?
     @energy_first = @energy.collect { |t, d|   { t => d.first[:total] } }.first.values
     @energy_last =  @energy.collect { |t, d|   { t => d.last[:total] } }
     @energy_last = @energy_last.map{|x| x.values}.collect {|ind| ind[0]}
     @daily_bar = []
     counter = 0
     first = 0
     last = 0
     empty = true
     @count.each_index do |i|
       if empty == true
         first = i
       end
       if @count[i] != 0
        #  last = i
         counter = counter + 1
         empty = false
       end
     end
     a = counter - 1
     b = counter
    @count.each_index do |index|
      if @count[index] != 0
        if first == index
           @daily_bar << @energy_last[0] - @energy_first[0]
        else
        #  @daily_bar << 1
           @daily_bar << @energy_last[counter - a] - @energy_last[counter - b]
           a = a - 1
           b = b - 1
       end
      elsif @count[index] == 0
        @daily_bar << @count[index]
      end
   end
   return @daily_bar
 else
   @empty = []
   sd = Date.parse(params[:start_date])
   ed = Date.parse(params[:start_date])
   ed = ed+ 1.month - 1.day
   sd.upto(ed) {|date| @empty << 0}
   return @empty
  end
end

  def daily
  #koding energi per hari old vversion tapi jalan kok
  # @start_date = params[:start_date].to_date.beginning_of_day
  # @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
  # @energy = @energy.where(:created_at => @start_date..Time.now)
  # @energy_by_day = @energy.group_by {|t| t.created_at.beginning_of_day}
  # @energy_by_day =  @energy_by_day.collect { |day, total| { day => total.last[:total] - total.first[:total] } }.take(6)
  # @energy_by_day = @energy_by_day.map do |g|
  #         k, v = g.first
  #         { "date"=> k.to_s, "value"=>v }
  #         end
  #@energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  #@energy = Energy.select("date_trunc( 'day', created_at ) as day, sum(energy_delta) as total_energy").group('day').take(6).order(created_at: :desc)
  #  @energy = @energy.group_by { |t| t.created_at.beginning_of_month }
  #  @start_date = params[:start_date].to_date.beginning_of_day
  #   @energy = Energy.all.group_by_day(:created_at, range: @start_date..Time.now).take(6)
  # orders = Energy.group("date(created_at)")
  # orders = Energy.select("date(created_at), sum(power) as total_amount")
  # orders =  orders.group_by { |order| order.created_at.to_date }
  #  @start_date = params[:start_date].to_date.beginning_of_day

  #  @energy = Energy.group_by_day(:created_at, range: @start_date..Time.now).take(6)
  #@energy = @energy.to_a
  #keys = [:date, :total_energy]
  #@energy = @energy.first - @energy.last
  #   @energy = @energy.each.map {|value| Hash[keys.zip(value)]}
  render json: get_daily(params[:start_date].to_date.beginning_of_month)
end

  def get_weekly(start_date)
    Time.zone = "Bangkok"
    @count = Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_week('energies.created_at', range: start_date - 6.week ..start_date + 6.week - 1.day).count(:total)
    @count = @count.collect {|ind| ind[1]}

    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where('energies.created_at' => (start_date - 6.week).in_time_zone("Bangkok")..(start_date + 6.week - 1.day).in_time_zone("Bangkok")).group_by {|t| t.created_at.beginning_of_week}

    @energy_first = @energy.collect { |t, d|   { t => d.first[:total] } }.first.values
    @energy_last =  @energy.collect { |t, d|   { t => d.last[:total] } }
    @energy_last = @energy_last.map{|x| x.values}.collect {|ind| ind[0]}
    @weekly_bar = []
    counter = 0
    first = 0
    last = 0
    empty = true
    @count.each_index do |i|
      if empty == true
        first = i
      end
      if @count[i] != 0
        last = i
        empty = false
      end
    end

   a = counter - 1
   b = counter
   @count.each_index do |index|
     if @count[index] != 0
       if first == index
          @weekly_bar << @energy_last[0] - @energy_first[0]
       else
          @weekly_bar << @energy_last[counter - a] - @energy_last[counter - b]
          a = a - 1
          b = b - 1
      end
     elsif @count[index] == 0
       @weekly_bar << @count[index]
     end
  end
  return @weekly_bar
  end

  def weekly

    #kodingan old but gold
    # @start_date = params[:start_date].to_date.beginning_of_day
    # @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    # @energy = @energy.where(:created_at => @start_date..Time.now)
    # @energy_by_week = @energy.group_by {|t| t.created_at.beginning_of_week}
    # @energy_by_week =  @energy_by_week.collect { |week, total| { week => total.last[:total] - total.first[:total] } }.take(6)
    # @energy_by_week = @energy_by_week.map do |g|
    #         k, v = g.first
    #         { "date"=> k.to_s, "value"=>v }
    #         end
    render json: get_weekly(params[:start_date].to_date.beginning_of_week)
  end
  def get_monthly(start_date)
    Time.zone = "Bangkok"
    @count = Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_month('energies.created_at', range: start_date..start_date + 1.year - 1.day).count(:total)
    @count = @count.collect {|ind| ind[1]}

    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where('energies.created_at' => start_date.in_time_zone("Bangkok")..(start_date + 1.year - 1.day).in_time_zone("Bangkok")).group_by {|t| t.created_at.beginning_of_month}
    if not @energy.empty?
    @energy_first = @energy.collect { |t, d|   { t => d.first[:total] } }.first.values
    @energy_last =  @energy.collect { |t, d|   { t => d.last[:total] } }
    @energy_last = @energy_last.map{|x| x.values}.collect {|ind| ind[0]}
    @monthly_bar = []
    counter = 0
    first = 0
    last = 0
    empty = true
    @count.each_index do |i|
      if empty == true
        first = i
      end
      if @count[i] != 0
        last = i
        empty = false
      end
    end
    a = counter - 1
    b = counter
   @count.each_index do |index|
     if @count[index] != 0
       if first == index
          @monthly_bar << @energy_last[0] - @energy_first[0]
       else
          @monthly_bar << @energy_last[counter - a] - @energy_last[counter - b]
          a = a - 1
          b = b - 1
      end
     elsif @count[index] == 0
       @monthly_bar << @count[index]
     end
  end
  return @monthly_bar
else
  @empty = []
  sd = Date.parse(params[:start_date])
  ed = Date.parse(params[:start_date])
  ed = ed+ 11.days
  sd.upto(ed) {|date| @empty << 0}
  return @empty
 end
  end

  def monthly

    # kodingan energy by month old version dengan hasil bener tapi proses bisnis salah
    # @start_date = params[:start_date].to_date.beginning_of_day
    # @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    # @energy = @energy.where(:created_at => @start_date..Time.now)
    # @energy_by_month = @energy.group_by {|t| t.created_at.beginning_of_month}
    # @energy_by_month =  @energy_by_month.collect { |month, total| { month => total.last[:total] - total.first[:total] } }.take(6)
    # @energy_by_month = @energy_by_month.map do |g|
    #         k, v = g.first
    #         { "date"=> k.to_s, "value"=>v }
    #         end

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

            #.map {|h| Hash[%w(date value).zip(h.keys + h.values)]}

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
    render json: get_monthly(params[:start_date].to_date.beginning_of_year)
  end
  def get_yearly(start_date)
    Time.zone = "Bangkok"
    @count = Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_year('energies.created_at', range: start_date - 6.year..start_date + 6.year - 1.day).count(:total)
    @count = @count.collect {|ind| ind[1]}

    @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    @energy = @energy.where('energies.created_at' => (start_date - 6.year).in_time_zone("Bangkok")..(start_date + 6.year - 1.day).in_time_zone("Bangkok")).group_by {|t| t.created_at.beginning_of_year}
    if not @energy.empty?
    @energy_first = @energy.collect { |t, d|   { t => d.first[:total] } }.first.values
    @energy_last =  @energy.collect { |t, d|   { t => d.last[:total] } }
    @energy_last = @energy_last.map{|x| x.values}.collect {|ind| ind[0]}
    @yearly_bar = []
    counter = 0
    first = 0
    last = 0
    empty = true
    @count.each_index do |i|
      if empty == true
        first = i
      end
      if @count[i] != 0
        last = i
        empty = false
      end
    end
    a = counter - 1
    b = counter
   @count.each_index do |index|
     if @count[index] != 0
       if first == index
          @yearly_bar << @energy_last[0] - @energy_first[0]
       else
          @yearly_bar << @energy_last[counter - a] - @energy_last[counter - b]
          a = a - 1
          b = b - 1
      end
     elsif @count[index] == 0
       @yearly_bar << @count[index]
     end
  end
  return @yearly_bar
else
  @empty = []
  sd = Date.parse(params[:start_date])
  ed = Date.parse(params[:start_date])
  ed = ed+ 11.day
  sd.upto(ed) {|date| @empty << 0}
  return @empty
 end
  end

  def yearly


  # @energy = Energy.select("id,created_at").where(:created_at => (params[:start_date].to_date.beginning_of_day)..Time.now)
  # @energy = Energy.select("date_trunc( 'year', created_at ) as year, sum(energy_delta) as total_energy").group('year').take(6)
  # render json: @energy
  #  @energy = Energy.group_by{|energy_delta| energy.created_at.day}

    #koding old but gold
    # @start_date = params[:start_date].to_date.beginning_of_day
    # @energy = Energy.joins(:home).where('homes.id = ?', params[:home_id]).select("total,energies.created_at").order('created_at ASC')
    # @energy = @energy.where(:created_at => @start_date..Time.now)
    # @energy_by_year = @energy.group_by {|t| t.created_at.beginning_of_year}
    # @energy_by_year =  @energy_by_year.collect { |year, total| { year => total.last[:total] - total.first[:total] } }.take(6)
    # @energy_by_year = @energy_by_year.map do |g|
    #         k, v = g.first
    #         { "date"=> k.to_s, "value"=>v }
    #         end
    # @energy = @energy.to_a
    # keys = [:date, :total]
    # @energy = @energy.each.map {|energy_delta| Hash[keys.zip(energy_delta)]}
    render json: get_yearly(params[:start_date].to_date.beginning_of_year)
  end

  def current_hourly
    @start_date = params[:start_date].to_date.beginning_of_day
    @current = Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_hour('energies.created_at', range: @start_date..@start_date + 23.hour + 59.minute).average(:cA)
    @current = @current.to_a
    keys = [:date, :value]
    @current= @current.each.map {|value| Hash[keys.zip(value)]}
    #@Humidity.shift
    render json: @current
  end
  def current_daily
    @start_date = params[:start_date].to_date.beginning_of_month
    @current = Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_day('energies.created_at', range: @start_date..@start_date + 1.month - 1.day).average(:cA)
    @current = @current.to_a
    keys = [:date, :value]
    @current= @current.each.map {|value| Hash[keys.zip(value)]}
    #@Humidity.shift
    render json: @current
  end

  def voltage_hourly
    @start_date = params[:start_date].to_date.beginning_of_day
    @volt= Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_hour('energies.created_at', range: @start_date..@start_date + 23.hour + 59.minute).average(:vA)
    @volt = @volt.to_a
    keys = [:date, :value]
    @volt= @volt.each.map {|value| Hash[keys.zip(value)]}
    #@Humidity.shift
    render json: @volt
  end
  def voltage_daily
    @start_date = params[:start_date].to_date.beginning_of_month
    @volt = Energy.joins(:home).where('homes.id = ?',params[:home_id]).group_by_day('energies.created_at', range: @start_date..@start_date + 1.month - 1.day).average(:cA)
    @volt = @volt.to_a
    keys = [:date, :value]
    @volt = @volt.each.map {|value| Hash[keys.zip(value)]}
    #@Humidity.shift
    render json: @volt
  end

  # def supply(home_id)
  #   @home = Home.find(home_id)
  #   @supply = @home.supply
  #   if @supply = 1300
  #     @supply = 1467.28
  #   elsif @supply = 2200
  #     @supply = 1467.28
  #   elsif @supply = 3500
  #     @supply = 1467.28
  #   elsif @supply = 5500
  #     @supply = 1467.28
  #   elsif @supply = 6600
  #     @supply = 1467.28
  #   end
  #   return @supply
  # end

  def cost_daily
    @cost_daily = get_daily(params[:start_date].to_date.beginning_of_month)
    @supply = supply(params[:home_id])
    @cost_daily = @cost_daily.collect { |n| (n * @supply)/1000 }
     render json: @cost_daily
  end

  def cost_monthly
    @cost_monthly = get_monthly(params[:start_date].to_date.beginning_of_year)
    @supply = supply(params[:home_id])
    @cost_monthly = @cost_monthly.collect { |n| (n * @supply)/1000 }
     render json: @cost_monthly
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy
      @energy = Energy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_params
    params.permit(:devid, :cA, :vA, :pwr, :energy_delta, :total, :tcA, :rpA, :pfA)
    end
end
