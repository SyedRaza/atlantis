require 'test_helper'

class ResourceVteamAllocationsControllerTest < ActionController::TestCase
  setup do
    @resource_vteam_allocation = resource_vteam_allocations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resource_vteam_allocations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource_vteam_allocation" do
    assert_difference('ResourceVteamAllocation.count') do
      post :create, :resource_vteam_allocation => @resource_vteam_allocation.attributes
    end

    assert_redirected_to resource_vteam_allocation_path(assigns(:resource_vteam_allocation))
  end

  test "should show resource_vteam_allocation" do
    get :show, :id => @resource_vteam_allocation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @resource_vteam_allocation.to_param
    assert_response :success
  end

  test "should update resource_vteam_allocation" do
    put :update, :id => @resource_vteam_allocation.to_param, :resource_vteam_allocation => @resource_vteam_allocation.attributes
    assert_redirected_to resource_vteam_allocation_path(assigns(:resource_vteam_allocation))
  end

  test "should destroy resource_vteam_allocation" do
    assert_difference('ResourceVteamAllocation.count', -1) do
      delete :destroy, :id => @resource_vteam_allocation.to_param
    end

    assert_redirected_to resource_vteam_allocations_path
  end
end
