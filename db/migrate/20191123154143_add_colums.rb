class AddColums < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :email, :string
    add_column :authors, :password_digest, :string
    add_index :authors, :email, unique: true
  end
end
