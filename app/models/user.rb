class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
<<<<<<< HEAD
          
=======
>>>>>>> 43d8ae69aa1c1ce61ca02044cacb080aa6b97770
  include DeviseTokenAuth::Concerns::User
end
