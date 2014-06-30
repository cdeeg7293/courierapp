require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  fixtures :addresses
  
  test "should save valid address" do
    valid_address = addresses(:valid_address)
    assert valid_address.save
  end
  
  test "should not save blank address" do
    test_address = Address.new
    assert_not test_address.save
  end   
  
  test "full_address function" do
    test_address = Address.new( city: "city", street: "street", building: "building", apartment: 1)
    assert_equal test_address.full_address, "city street building 1"
  end
  
  test "full_address_ru function" do
    test_address_rus = Address.new( city: "Донецк", street: "Постышева", building: "1А", apartment: 15)
    assert_equal test_address_rus.full_address_rus, "г. Донецк ул. Постышева д. 1А кв. 15"
  end

end
