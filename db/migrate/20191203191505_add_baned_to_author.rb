class AddBanedToAuthor < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :baned, :boolean, default: false
  end
end
