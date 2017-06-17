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
end
