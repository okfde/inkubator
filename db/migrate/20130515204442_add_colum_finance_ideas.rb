class AddColumFinanceIdeas < ActiveRecord::Migration
  def change
    change_table :ideas do |t|
        t.text :finance
    end
  end
end
