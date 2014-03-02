class CreateCouriers < ActiveRecord::Migration
  def change
    create_table :couriers do |t|
      t.references :client, index: true
      t.references :address, index: true

      t.timestamps
    end
  end
end
