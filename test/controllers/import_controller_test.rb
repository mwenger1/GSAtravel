require 'test_helper'

class ImportControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get run" do
    get :run
    assert_response :success
  end

  test "should get delete_all" do
    get :delete_all
    assert_response :success
  end

end
