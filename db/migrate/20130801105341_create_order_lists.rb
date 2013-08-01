class CreateOrderLists < ActiveRecord::Migration
  def change
    create_table :order_lists do |t|
      t.string :name
      t.timestamps
    end
  end
end
