class LightsController < ApplicationController
  before_action :set_light, only: [:show, :update, :destroy]

  # GET /lights
  def index
    @lights = Light.all

    render json: @lights
  end

  # GET /lights/1
  def show
    render json: @light
  end

  # POST /lights
  def create
    @light = Light.new(light_params)

    if @light.save
      render json: @light, status: :created, location: @light
    else
      render json: @light.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lights/1
  def update
    if @light.update(light_params)
      render json: @light
    else
      render json: @light.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lights/1
  def destroy
    @light.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light
      @light = Light.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def light_params
      params.require(:light).permit(:value)
    end
end
