require 'test_helper'

class AcBrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ac_brand = ac_brands(:one)
  end

  test "should get index" do
    get ac_brands_url
    assert_response :success
  end

  test "should get new" do
    get new_ac_brand_url
    assert_response :success
  end

  test "should create ac_brand" do
    assert_difference('AcBrand.count') do
      post ac_brands_url, params: { ac_brand: { brand: @ac_brand.brand, code: @ac_brand.code } }
    end

    assert_redirected_to ac_brand_url(AcBrand.last)
  end

  test "should show ac_brand" do
    get ac_brand_url(@ac_brand)
    assert_response :success
  end

  test "should get edit" do
    get edit_ac_brand_url(@ac_brand)
    assert_response :success
  end

  test "should update ac_brand" do
    patch ac_brand_url(@ac_brand), params: { ac_brand: { brand: @ac_brand.brand, code: @ac_brand.code } }
    assert_redirected_to ac_brand_url(@ac_brand)
  end

  test "should destroy ac_brand" do
    assert_difference('AcBrand.count', -1) do
      delete ac_brand_url(@ac_brand)
    end

    assert_redirected_to ac_brands_url
  end
end
