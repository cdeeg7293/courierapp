require 'test_helper'

class CourierTest < ActiveSupport::TestCase
  fixtures :couriers
  
  test "should create associated models" do
    courier = couriers(:valid_courier)
    assert_not courier.address.nil? && courier.client.nil?
  end
end
