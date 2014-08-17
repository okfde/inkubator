class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title, :null => false
      t.text :description, :null => false
      t.integer  :user_id
      t.text :problem
      t.text :goal
      t.text :impact
      t.timestamps
    end
  end
end