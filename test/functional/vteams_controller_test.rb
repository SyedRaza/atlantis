require 'test_helper'

class VteamsControllerTest < ActionController::TestCase
  setup do
    @vteam = vteams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vteams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vteam" do
    assert_difference('Vteam.count') do
      post :create, :vteam => @vteam.attributes
    end

    assert_redirected_to vteam_path(assigns(:vteam))
  end

  test "should show vteam" do
    get :show, :id => @vteam.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @vteam.to_param
    assert_response :success
  end

  test "should update vteam" do
    put :update, :id => @vteam.to_param, :vteam => @vteam.attributes
    assert_redirected_to vteam_path(assigns(:vteam))
  end

  test "should destroy vteam" do
    assert_difference('Vteam.count', -1) do
      delete :destroy, :id => @vteam.to_param
    end

    assert_redirected_to vteams_path
  end
end
