require 'test_helper'

class XDocGeneralsControllerTest < ActionController::TestCase
  setup do
    @x_doc_general = x_doc_generals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:x_doc_generals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create x_doc_general" do
    assert_difference('XDocGeneral.count') do
      post :create, :x_doc_general => @x_doc_general.attributes
    end

    assert_redirected_to x_doc_general_path(assigns(:x_doc_general))
  end

  test "should show x_doc_general" do
    get :show, :id => @x_doc_general.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @x_doc_general.to_param
    assert_response :success
  end

  test "should update x_doc_general" do
    put :update, :id => @x_doc_general.to_param, :x_doc_general => @x_doc_general.attributes
    assert_redirected_to x_doc_general_path(assigns(:x_doc_general))
  end

  test "should destroy x_doc_general" do
    assert_difference('XDocGeneral.count', -1) do
      delete :destroy, :id => @x_doc_general.to_param
    end

    assert_redirected_to x_doc_generals_path
  end
end
