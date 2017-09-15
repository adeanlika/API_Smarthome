
class Cron
  def self.saving_daily
    @users = User.all

    @users.each do |user|
      Time.zone ="Bangkok"
      @homes = user.homes
      @fcm_token = user.fcm_token

      if @homes.present? and @homes.size > 0
        @homes.each do |home|
          @start_date = (Date.yesterday).to_date

          @daily_max = Home.find(home.id).upperenergy * 1000 / 30
          @energy_last = Energy.where('home_id = ?',home.id).where('created_at BETWEEN ? AND ?', @start_date.beginning_of_day,@start_date.end_of_day).pluck(:total).last.to_json
          @energy_first = Energy.where('created_at < ? AND home_id = ?',(@start_date).in_time_zone("Bangkok"),home.id).order('created_at ASC').pluck('total').last
          # @energy_last = @energy_last.pluck(:total)

          @presentage = (((@daily_max.to_f - (@energy_last.to_f - @energy_first.to_f))/@daily_max.to_f) * 100)

          fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
          registration_ids = []
          registration_ids.push(@fcm_token)
          options = {data:{code: "SAVING"}, notification: {body: "Yesterday, you saved #{@presentage} % energy", title: "#{home.name}"  }}
          response = fcm.send(registration_ids, options)
          p "Yesterday, #{home.name} saved #{@presentage} % energy #{Time.now}"
        end
      end

    end

  end

  def testing
    p "test test test"
  end

  end
