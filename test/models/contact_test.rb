require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  fixtures :contact_types
  
  test "should not save empty contact object" do
    contact = Contact.new
    assert_not contact.save, "Should not save a contact without type and value"
    contact.contact_type = contact_types(:valid_contact_type)
    assert_not contact.save, "Should not save a contact without value"
    contact.value = "123455"
    assert contact.save, "Should save a contact with type and value"
  end
end
