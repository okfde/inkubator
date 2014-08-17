class AddColumnVotings < ActiveRecord::Migration
  def self.up
    change_table :votings do |t|
      t.integer :problem
      t.integer :impact
      t.integer :finance
      t.integer :goal
    end
  end
end
