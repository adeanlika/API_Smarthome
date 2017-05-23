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

end
