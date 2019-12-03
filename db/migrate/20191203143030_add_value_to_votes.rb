class AddValueToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :value, :integer
  end
end
