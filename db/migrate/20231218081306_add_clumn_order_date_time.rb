class AddClumnOrderDateTime < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :order_date_time, :datetime
  end
end
