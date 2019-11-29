class RemoveFieldNameFromPosts < ActiveRecord::Migration[6.0]
  def change

    remove_column :posts, :name
  end
end
