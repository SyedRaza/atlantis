require 'test_helper'

class XdocsControllerTest < ActionController::TestCase
  setup do
    @xdoc = xdocs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xdocs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xdoc" do
    assert_difference('Xdoc.count') do
      post :create, :xdoc => @xdoc.attributes
    end

    assert_redirected_to xdoc_path(assigns(:xdoc))
  end

  test "should show xdoc" do
    get :show, :id => @xdoc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @xdoc.to_param
    assert_response :success
  end

  test "should update xdoc" do
    put :update, :id => @xdoc.to_param, :xdoc => @xdoc.attributes
    assert_redirected_to xdoc_path(assigns(:xdoc))
  end

  test "should destroy xdoc" do
    assert_difference('Xdoc.count', -1) do
      delete :destroy, :id => @xdoc.to_param
    end

    assert_redirected_to xdocs_path
  end
end
