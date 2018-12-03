require 'test_helper'

class PropectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get propects_index_url
    assert_response :success
  end

  test "should get new" do
    get propects_new_url
    assert_response :success
  end

  test "should get edit" do
    get propects_edit_url
    assert_response :success
  end

end
