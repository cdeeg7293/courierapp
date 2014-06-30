require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :orders
  
  test "validate sum" do
    order = orders(:order_1)
    order.sum = -1
    assert_not order.valid?, "Negative sum passes validation"
    order.sum = 0
    assert_not order.valid?, "Zero sum passes validation"
    order.sum = 1
    assert order.valid?, "Positive sum does not pass validation"
  end
  
  test "should not save empty order" do
    order = Order.new
    assert_not order.save
  end
end
