class AddTeachIdToQuestions < ActiveRecord::Migration[5.1]
  def up
    add_column :questions, :teacher_id, :integer
  end

  def down
    remove_column :questions, :teacher_id, :integer
  end
end
