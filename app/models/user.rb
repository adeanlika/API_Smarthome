class User < ActiveRecord::Base
  # Include default devise modules.
  mount_uploader :image, AvatarUploader

# Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :remember_me, :avatar, :avatar_cache, :remove_avatar

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
#<<<<<<< HEAD

#=======
#>>>>>>> 43d8ae69aa1c1ce61ca02044cacb080aa6b97770
  include DeviseTokenAuth::Concerns::User
end
