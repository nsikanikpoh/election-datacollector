require 'test_helper'

class InterestLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interest_line = interest_lines(:one)
  end

  test "should get index" do
    get interest_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_interest_line_url
    assert_response :success
  end

  test "should create interest_line" do
    assert_difference('InterestLine.count') do
      post interest_lines_url, params: { interest_line: { description: @interest_line.description, name: @interest_line.name } }
    end

    assert_redirected_to interest_line_url(InterestLine.last)
  end

  test "should show interest_line" do
    get interest_line_url(@interest_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_interest_line_url(@interest_line)
    assert_response :success
  end

  test "should update interest_line" do
    patch interest_line_url(@interest_line), params: { interest_line: { description: @interest_line.description, name: @interest_line.name } }
    assert_redirected_to interest_line_url(@interest_line)
  end

  test "should destroy interest_line" do
    assert_difference('InterestLine.count', -1) do
      delete interest_line_url(@interest_line)
    end

    assert_redirected_to interest_lines_url
  end
end
