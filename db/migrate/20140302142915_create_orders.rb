class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :number
      t.references :sender, index: true
      t.references :receiver, index: true
      t.decimal :sum
      t.datetime :delivered_date
      t.datetime :issued_date

      t.timestamps
    end
  end
end
