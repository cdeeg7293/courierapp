class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.references :order, index: true
      t.references :courier, index: true
      t.datetime :date_planned
      t.text :comment

      t.timestamps
    end
  end
end
