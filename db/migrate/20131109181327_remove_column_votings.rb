class RemoveColumnVotings < ActiveRecord::Migration
  def self.up
    change_table :votings do |t|
      t.remove :problem
      t.remove :impact
      t.remove :finance
      t.remove :goal
    end
  end
end
