require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get overview" do
    get :overview
    assert_response :success
  end

  test "should get transactions" do
    get :transactions
    assert_response :success
  end

  test "should get budgets" do
    get :budgets
    assert_response :success
  end

  test "should get trends" do
    get :trends
    assert_response :success
  end

  test "should get ways_to_save" do
    get :ways_to_save
    assert_response :success
  end

end
