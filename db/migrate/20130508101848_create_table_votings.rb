class CreateTableVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.integer :user_id
      t.integer :idea_id
      t.boolean :problem
      t.boolean :goal
      t.boolean :impact
      t.boolean :finance
      t.timestamps
    end
  end
end
