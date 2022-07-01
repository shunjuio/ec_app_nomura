class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :member, foreign_key: true
      t.integer :postage
      t.integer :amount_billed
      t.integer :payment_method
      t.string :shipping_address
      t.integer :postal_code

      t.timestamps
    end
  end
end
