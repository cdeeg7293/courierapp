class AddAdding < ActiveRecord::Migration
  def change
    remove_column :clients, :name
    add_column :clients, :first_name, :string
    add_column :clients, :patronymic, :string
    add_column :clients, :last_name, :string
    add_column :clients, :is_person, :boolean
  end
end
