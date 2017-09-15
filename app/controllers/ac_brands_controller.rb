class AcBrandsController < ApplicationController
  before_action :set_ac_brand, only: [:show, :edit, :update, :destroy]

  # GET /ac_brands
  def index
    @ac_brands = AcBrand.all
    render json: @ac_brands
  end

  # GET /ac_brands/1
  def show
      render json: @ac_brand
  end

  # GET /ac_brands/new
  def new
    @ac_brand = AcBrand.new
  end

  # GET /ac_brands/1/edit
  def edit
  end

  # POST /ac_brands
  def create
    @ac_brand = AcBrand.new(ac_brand_params)

    if @ac_brand.save
      redirect_to @ac_brand, notice: 'Ac brand was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ac_brands/1
  def update
    if @ac_brand.update(ac_brand_params)
      redirect_to @ac_brand, notice: 'Ac brand was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ac_brands/1
  def destroy
    @ac_brand.destroy
    redirect_to ac_brands_url, notice: 'Ac brand was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ac_brand
      @ac_brand = AcBrand.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ac_brand_params
      params.require(:ac_brand).permit(:brand, :code)
    end
end
