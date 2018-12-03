require 'test_helper'

class FundRaisersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fund_raisers_index_url
    assert_response :success
  end

  test "should get new" do
    get fund_raisers_new_url
    assert_response :success
  end

  test "should get edit" do
    get fund_raisers_edit_url
    assert_response :success
  end

end
