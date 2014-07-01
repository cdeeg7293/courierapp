require 'test_helper'

class CouriersControllerTest < ActionController::TestCase
  setup do
    @courier = couriers(:valid_courier)
    @user = users(:test_user)
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:couriers)
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

#   test "should create courier" do
#     sign_in @user
#     assert_difference('Courier.count') do
#       # TODO:write a proper creation model (client_attributes: {...}, address_attributes: {...})
#       post :create, courier: { address_id: @courier.address.id, client_id: @courier.client.id }
#     end
# 
#     assert_redirected_to courier_path(assigns(:courier))
#   end

  test "should show courier" do
    sign_in @user
    get :show, id: @courier
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @courier
    assert_response :success
  end

  test "should update courier" do
    sign_in @user
    patch :update, id: @courier, courier: { address_id: @courier.address_id, client_id: @courier.client_id }
    assert_redirected_to courier_path(assigns(:courier))
  end

  test "should destroy courier" do
    sign_in @user
    assert_difference('Courier.count', -1) do
      delete :destroy, id: @courier
    end

    assert_redirected_to couriers_path
  end
end
