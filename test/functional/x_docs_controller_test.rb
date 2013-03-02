require 'test_helper'

class XDocsControllerTest < ActionController::TestCase
  setup do
    @note = x_docs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:x_docs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create x_doc" do
    assert_difference('XDoc.count') do
      post :create, :x_doc => @note.attributes
    end

    assert_redirected_to x_doc_path(assigns(:x_doc))
  end

  test "should show x_doc" do
    get :show, :id => @note.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @note.to_param
    assert_response :success
  end

  test "should update x_doc" do
    put :update, :id => @note.to_param, :x_doc => @note.attributes
    assert_redirected_to x_doc_path(assigns(:x_doc))
  end

  test "should destroy x_doc" do
    assert_difference('XDoc.count', -1) do
      delete :destroy, :id => @note.to_param
    end

    assert_redirected_to x_docs_path
  end
end
