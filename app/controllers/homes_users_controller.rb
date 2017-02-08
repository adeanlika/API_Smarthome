class HomesUsersController < ApplicationController
  before_action :set_homes_user, only: [:show, :update, :destroy]

  # GET /homes_users
  def index
    @homes_users = HomesUser.all

    render json: @homes_users
  end

  # GET /homes_users/1
  def show
    render json: @homes_user
  end

  # POST /homes_users
  def create
    @homes_user = HomesUser.new(homes_user_params)

    if @homes_user.save
      render json: @homes_user, status: :created, location: @homes_user
    else
      render json: @homes_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /homes_users/1
  def update
    if @homes_user.update(homes_user_params)
      render json: @homes_user
    else
      render json: @homes_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /homes_users/1
  def destroy
    @homes_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homes_user
      @homes_user = HomesUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def homes_user_params
      params.require(:homes_user).permit(:user_id, :home_id)
    end
end
