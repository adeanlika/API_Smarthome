class User < ActiveRecord::Base
  # Include default devise modules.
  mount_uploader :image, AvatarUploader
  validates_confirmation_of :password, :only => [:create, :update]
#   validates :password, :on => :create
# validates :password_confirmation, presence: true, :on => :update
# Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :remember_me, :avatar, :avatar_cache, :remove_avatar

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
#<<<<<<< HEAD

#=======
#>>>>>>> 43d8ae69aa1c1ce61ca02044cacb080aa6b97770
  include DeviseTokenAuth::Concerns::User

  has_many :homes, through: :homes_users
  has_many :homes_users

  def self.saving_daily
    @users = User.all

    @users.each do |user|
      Time.zone ="Bangkok"
      @homes = user.homes
      @fcm_token = user.fcm_token

      @homes.each do |home|
        @start_date = (Date.yesterday).to_date

        @daily_max = Home.find(home.id).upperenergy / 30
        @energy_last = Energy.where('home_id = ?',home.id).where('created_at BETWEEN ? AND ?', @start_date.beginning_of_day,@start_date.end_of_day).pluck(:total).last.to_json
        @energy_first = Energy.where('created_at < ? AND home_id = ?',(@start_date - 1 .day).in_time_zone("Bangkok"),home.id).order('created_at ASC').pluck('total').last
        # @energy_last = @energy_last.pluck(:total)

        @presentage = (((@energy_last.to_f - @energy_first.to_f)/@daily_max.to_f) * 100)

        fcm = FCM.new("AAAAp97oDyY:APA91bFTmSnZxPTHJBvitG06LR8AgCGJX6gpa5CuHJDGFMi2WTs2ZcV2TgjiclUwAJ8i8V_BsqhhEFX5RPBC-Wbx1bsoJJDAeJESTYyCGgpgXESMMdBvoqvTT36AzpFd-olhNnYt5obH")
        registration_ids = []
        registration_ids.push(@fcm_token)
        options = {data:{code: "SAVING"}, notification: {body: "You saved #{@presentage} %", title: "Daily energy saving"  }}
        response = fcm.send(registration_ids, options)
      end
    end

  end

end
