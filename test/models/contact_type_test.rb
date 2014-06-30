require 'test_helper'

class ContactTypeTest < ActiveSupport::TestCase
  test "validation test" do
    contact_type = ContactType.new
    assert_not contact_type.save, "Should not save a contact type without name"
    contact_type.type_name = "Type name"
    assert contact_type.save, "Should save a contact type with name"
  end
end
