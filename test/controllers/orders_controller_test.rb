require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:order_1)
    @user = users(:test_user)
  end

  test "should get index" do
    #TODO: fullname is nil and the test crashes. Investigate why.
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should create order" do
    sign_in @user
    Rails::logger.debug @order.inspect + '8885'
    assert_difference('Order.count') do
      post :create, order: { delivered_date: @order.delivered_date, receiver_id: @order.receiver.id, sender_id: @order.sender.id, sum: @order.sum }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    sign_in @user
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    sign_in @user
    patch :update, id: @order, order: { delivered_date: @order.delivered_date, issued_date: @order.issued_date, number: @order.number, receiver_id: @order.receiver_id, sender_id: @order.sender_id, sum: @order.sum }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    sign_in @user
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
