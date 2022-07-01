class AddColumnToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :purchaser_last_name, :string
    add_column :orders, :purchaser_first_name, :string
    add_column :orders, :purchaser_email, :string
  end
end
