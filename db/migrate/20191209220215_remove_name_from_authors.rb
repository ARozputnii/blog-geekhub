class RemoveNameFromAuthors < ActiveRecord::Migration[6.0]
  def change

    remove_column :authors, :password_reset_token, :string
  end
end
