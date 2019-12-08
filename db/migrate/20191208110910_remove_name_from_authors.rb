class RemoveNameFromAuthors < ActiveRecord::Migration[6.0]
  def change

    remove_column :authors, :activated, :boolean
    remove_column :authors, :activated_at, :datetime
    remove_column :authors, :activation_digest, :string
    remove_column :authors, :confirmation_email, :boolean
    remove_column :authors, :remember_digest, :string
    remove_column :authors, :token, :string
  end
end
