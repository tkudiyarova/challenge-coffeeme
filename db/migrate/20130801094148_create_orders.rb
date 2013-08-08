class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.text :comment
      t.references :user
      t.references :drink
      t.timestamps
    end
  end
end
