require 'test_helper'

class EnergiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @energy = energies(:one)
  end

  test "should get index" do
    get energies_url, as: :json
    assert_response :success
  end

  test "should create energy" do
    assert_difference('Energy.count') do
      post energies_url, params: { energy: { Eday: @energy.Eday, Emonth: @energy.Emonth, Etotal: @energy.Etotal, Eyear: @energy.Eyear, power: @energy.power } }, as: :json
    end

    assert_response 201
  end

  test "should show energy" do
    get energy_url(@energy), as: :json
    assert_response :success
  end

  test "should update energy" do
    patch energy_url(@energy), params: { energy: { Eday: @energy.Eday, Emonth: @energy.Emonth, Etotal: @energy.Etotal, Eyear: @energy.Eyear, power: @energy.power } }, as: :json
    assert_response 200
  end

  test "should destroy energy" do
    assert_difference('Energy.count', -1) do
      delete energy_url(@energy), as: :json
    end

    assert_response 204
  end
end
