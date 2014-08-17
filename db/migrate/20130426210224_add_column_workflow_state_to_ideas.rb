class AddColumnWorkflowStateToIdeas < ActiveRecord::Migration
  def change
    change_table :ideas do |t|
      t.string :workflow_state
    end
  end
end
