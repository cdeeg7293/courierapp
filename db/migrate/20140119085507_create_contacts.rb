class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :type_name
      t.string :value
      t.references :client, index: true

      t.timestamps
    end
  end
end
