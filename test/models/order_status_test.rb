require 'test_helper'

class OrderStatusTest < ActiveSupport::TestCase
  fixtures :order_statuses
  
  test "should save a valid order status" do
    order_status = order_statuses(:order_status_1)
    assert order_status.save
  end
  
  test "should not save an emty order status" do 
    order_status = OrderStatus.new
    assert_not order_status.save
  end
end
