class CreateContactTypes < ActiveRecord::Migration
  def change
    create_table :contact_types do |t|
      t.string :type_name

      t.timestamps
    end
  end
end
