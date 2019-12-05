class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :vote
      t.belongs_to :comment, null: false, foreign_key: true
      t.belongs_to :author,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
