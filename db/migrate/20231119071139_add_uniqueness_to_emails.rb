class AddUniquenessToEmails < ActiveRecord::Migration[7.1]
  def change
    add_index :members, :email, unique: true
  end
end
