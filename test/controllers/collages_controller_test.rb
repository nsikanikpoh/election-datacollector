require 'test_helper'

class CollagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @collage = collages(:one)
  end

  test "should get index" do
    get collages_url
    assert_response :success
  end

  test "should get new" do
    get new_collage_url
    assert_response :success
  end

  test "should create collage" do
    assert_difference('Collage.count') do
      post collages_url, params: { collage: { pic: @collage.pic } }
    end

    assert_redirected_to collage_url(Collage.last)
  end

  test "should show collage" do
    get collage_url(@collage)
    assert_response :success
  end

  test "should get edit" do
    get edit_collage_url(@collage)
    assert_response :success
  end

  test "should update collage" do
    patch collage_url(@collage), params: { collage: { pic: @collage.pic } }
    assert_redirected_to collage_url(@collage)
  end

  test "should destroy collage" do
    assert_difference('Collage.count', -1) do
      delete collage_url(@collage)
    end

    assert_redirected_to collages_url
  end
end
