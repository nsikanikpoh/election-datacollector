require 'test_helper'

class QuickDonationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quick_donation = quick_donations(:one)
  end

  test "should get index" do
    get quick_donations_url
    assert_response :success
  end

  test "should get new" do
    get new_quick_donation_url
    assert_response :success
  end

  test "should create quick_donation" do
    assert_difference('QuickDonation.count') do
      post quick_donations_url, params: { quick_donation: { amount: @quick_donation.amount, email: @quick_donation.email, tel: @quick_donation.tel } }
    end

    assert_redirected_to quick_donation_url(QuickDonation.last)
  end

  test "should show quick_donation" do
    get quick_donation_url(@quick_donation)
    assert_response :success
  end

  test "should get edit" do
    get edit_quick_donation_url(@quick_donation)
    assert_response :success
  end

  test "should update quick_donation" do
    patch quick_donation_url(@quick_donation), params: { quick_donation: { amount: @quick_donation.amount, email: @quick_donation.email, tel: @quick_donation.tel } }
    assert_redirected_to quick_donation_url(@quick_donation)
  end

  test "should destroy quick_donation" do
    assert_difference('QuickDonation.count', -1) do
      delete quick_donation_url(@quick_donation)
    end

    assert_redirected_to quick_donations_url
  end
end
