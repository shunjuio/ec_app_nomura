class RemovePasswordFromMember < ActiveRecord::Migration[6.1]
  def change
    remove_column :members, :password, :string
  end
end
