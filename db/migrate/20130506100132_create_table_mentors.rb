class CreateTableMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.integer :user_id
      t.integer :idea_id
    end
  end
end
