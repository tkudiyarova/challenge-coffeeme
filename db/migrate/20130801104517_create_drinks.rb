class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :size
      t.text :comments
      t.references :order
      t.timestamps
    end
  end
end
