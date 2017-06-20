class UsersController < ApiController
  # before_action :authenticate_user!
	def index
	  @users = User.all

	  render json: @users
	end
	def show
		# @users = User.find(params[:id])
		render json: @users
	end


	# 	@user = User.find(current_user.id)
  # 	user = User.find_by_email(current_user.email).try(:authenticate, params[:current_password])
  # 	if user && @user.update_with_password(password_params)
	# 			# @user.save
  #   	 bypass_sign_in(@user)
	# 		 render json: true
  #   else
  #     render json: false
	#   end
	# end
# 	def update_password
# 	@user = User.find(current_user.id)
# 	if @user.update_with_password(password_params)
# 		# Sign in the user by passing validation in case their password changed
# 		bypass_sign_in(@user)
# 		render json: true
# 	else
# 		render json: false
# 	end
# end


	def update
		@users = User.find(params[:id])
		if @users.update(user_params)
			render json: @users
		else
			render json: @users.errors, status: :unprocessable_entity
		end
	end
	private
		# Use callbacks to share common setup or constraints between actions.
			# Only allow a trusted parameter "white list" through.
		def user_params
			params.permit(:provider, :uid, :name, :nickname, :image, :email, :fcm_token)
		end

		# def password_params
		# 	params.require(:user).permit(:password, :password_confirmation, :current_password)
		# end

end
