class HumiditiesController < ApplicationController
  before_action :set_humidity, only: [:show, :update, :destroy]

  # GET /humidities
  def index
    @humidities = Humidity.all

    render json: @humidities
  end

  # GET /humidities/1
  def show
    render json: @humidity
  end

  # POST /humidities
  def create
    @humidity = Humidity.new(humidity_params)

    if @humidity.save
      render json: @humidity, status: :created, location: @humidity
    else
      render json: @humidity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /humidities/1
  def update
    if @humidity.update(humidity_params)
      render json: @humidity
    else
      render json: @humidity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /humidities/1
  def destroy
    @humidity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_humidity
      @humidity = Humidity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def humidity_params
      params.require(:humidity).permit(:value)
    end
end
