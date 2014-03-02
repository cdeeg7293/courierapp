class AddingContactTypeToContacts < ActiveRecord::Migration
  def change
	remove_column :contacts, :type_name
	add_reference :contacts, :contact_type, index: true
  end
end
