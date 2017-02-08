class RelaysController < ApplicationController
  before_action :set_relay, only: [:show, :update, :destroy]

  # GET /relays
  def index
    @relays = Relay.all

    render json: @relays
  end

  # GET /relays/1
  def show
    render json: @relay
  end

  # POST /relays
  def create
    @relay = Relay.new(relay_params)

    if @relay.save
      render json: @relay, status: :created, location: @relay
    else
      render json: @relay.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /relays/1
  def update
    if @relay.update(relay_params)
      render json: @relay
    else
      render json: @relay.errors, status: :unprocessable_entity
    end
  end

  # DELETE /relays/1
  def destroy
    @relay.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relay
      @relay = Relay.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def relay_params
      params.fetch(:relay, {})
    end
end
