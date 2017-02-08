class EnergiesController < ApplicationController
  before_action :set_energy, only: [:show, :update, :destroy]

  # GET /energies
  def index
    @energies = Energy.all

    render json: @energies
  end

  # GET /energies/1
  def show
    render json: @energy
  end

  # POST /energies
  def create
    @energy = Energy.new(energy_params)

    if @energy.save
      render json: @energy, status: :created, location: @energy
    else
      render json: @energy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /energies/1
  def update
    if @energy.update(energy_params)
      render json: @energy
    else
      render json: @energy.errors, status: :unprocessable_entity
    end
  end

  # DELETE /energies/1
  def destroy
    @energy.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy
      @energy = Energy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_params
      params.require(:energy).permit(:power, :Etotal, :Eday, :Emonth, :Eyear)
    end
end
