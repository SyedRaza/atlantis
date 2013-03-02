require 'test_helper'

class XdocTypesControllerTest < ActionController::TestCase
  setup do
    @xdoc_type = xdoc_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xdoc_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xdoc_type" do
    assert_difference('XdocType.count') do
      post :create, :xdoc_type => @xdoc_type.attributes
    end

    assert_redirected_to xdoc_type_path(assigns(:xdoc_type))
  end

  test "should show xdoc_type" do
    get :show, :id => @xdoc_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @xdoc_type.to_param
    assert_response :success
  end

  test "should update xdoc_type" do
    put :update, :id => @xdoc_type.to_param, :xdoc_type => @xdoc_type.attributes
    assert_redirected_to xdoc_type_path(assigns(:xdoc_type))
  end

  test "should destroy xdoc_type" do
    assert_difference('XdocType.count', -1) do
      delete :destroy, :id => @xdoc_type.to_param
    end

    assert_redirected_to xdoc_types_path
  end
end
