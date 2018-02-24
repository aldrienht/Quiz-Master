class AddTeachIdToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :teacher_id, :integer
  end
end
