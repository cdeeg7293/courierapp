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

  test "should create courier" do
    sign_in @user
    
    contact = contacts(:valid_contact)
    
    assert_difference('Courier.count') do
      post :create, courier: { client_attributes: { first_name: @courier.client.first_name, last_name: @courier.client.last_name, patronymic: @courier.client.patronymic, is_person: @courier.client.is_person, address_attributes: { city: @courier.client.address.city, street: @courier.client.address.street, building: @courier.client.address.building, apartment: @courier.client.address.apartment }, contacts_attributes: [ contact_type_id: contact.contact_type.id, value: contact.value ] },
	address_attributes: { city: @courier.address.city, street: @courier.address.street, building: @courier.address.building, apartment: @courier.address.apartment }                                                                                                                                                                                                                                                      }
    end

    assert_redirected_to courier_path(assigns(:courier))
  end

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
