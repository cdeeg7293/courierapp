class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :street
      t.string :building
      t.integer :apartment

      t.timestamps
    end
  end
end
