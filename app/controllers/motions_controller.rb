class MotionsController < ApplicationController
  before_action :set_motion, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /motions
  def index
    @motions = Motion.all

    render json: @motions
  end

  # GET /motions/1
  def show
    render json: @motion
  end

  # POST /motions
  def create
    @motion = Motion.new(motion_params)

    if @motion.save
      render json: @motion, status: :created, location: @motion
    else
      render json: @motion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /motions/1
  def update
    if @motion.update(motion_params)
      render json: @motion
    else
      render json: @motion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /motions/1
  def destroy
    @motion.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motion
      @motion = Motion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def motion_params
      params.require(:motion).permit(:value)
    end
end
