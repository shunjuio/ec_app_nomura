class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :alcohol
      t.string :image_path
      t.string :material
      t.string :product_area

      t.timestamps
    end
  end
end
