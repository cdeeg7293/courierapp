require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  fixtures :clients
  
  test "should save valid client" do
    client = clients(:client_with_valid_address)
    assert client.save
  end
  
  test "client should have valid address" do
    client = clients(:client_with_invalid_address)
    assert_not client.save
  end
  
  test "should not save an empty client" do
    empty_client = Client.new
    assert_not empty_client.save
  end
  
  test "should create associated models on client creation" do
    client = Client.new(last_name: "Петров", first_name: "Иван", patronymic: "Петрович")
    assert_not client.address.nil? && client.contacts.nil?
  end
  
  test "full_name function" do 
    client = Client.new(last_name: "Петров", first_name: "Иван", patronymic: "Петрович")
    assert client.full_name, "Петров Иван Петрович"
  end
end
