require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @client = clients(:client_with_valid_address)
    @contact = contacts(:valid_contact)
    @user = users(:test_user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    #Rails::logger.debug  @user.inspect
    assert_difference('Client.count') do
      assert_difference('Address.count') do
	post :create, client: { first_name: @client.first_name, last_name: @client.last_name, patronymic: @client.patronymic, is_person: @client.is_person, address_attributes: { city: @client.address.city, street: @client.address.street, building: @client.address.building, apartment: @client.address.apartment }, contacts_attributes: [ contact_type_id: @contact.contact_type.id, value: @contact.value ] }
      end
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, id: @client
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @client
    assert_response :success
  end

  test "should update client" do
    patch :update, id: @client, client: { first_name: @client.first_name, last_name: @client.last_name, patronymic: @client.patronymic, is_person: @client.is_person, address_attributes: { city: @client.address.city, street: @client.address.street, building: @client.address.building, apartment: @client.address.apartment }, contacts_attributes: [ contact_type_id: @contact.contact_type.id, value: @contact.value ] }
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end
end
