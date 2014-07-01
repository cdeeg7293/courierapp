require 'test_helper'

class ContactTypesControllerTest < ActionController::TestCase
  setup do
    @contact_type = contact_types(:valid_contact_type)
    @user = users(:test_user)
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_types)
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should create contact_type" do
    sign_in @user
    assert_difference('ContactType.count') do
      post :create, contact_type: { type_name: @contact_type.type_name }
    end

    assert_redirected_to contact_types_path
  end

  test "should show contact_type" do
    sign_in @user
    get :show, id: @contact_type
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @contact_type
    assert_response :success
  end

  test "should update contact_type" do
    sign_in @user
    patch :update, id: @contact_type, contact_type: { type_name: @contact_type.type_name }
    assert_redirected_to contact_types_path
  end

  test "should destroy contact_type" do
    sign_in @user
    assert_difference('ContactType.count', -1) do
      delete :destroy, id: @contact_type
    end

    assert_redirected_to contact_types_path
  end
end
