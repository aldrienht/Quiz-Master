class CreateExamResults < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_results do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.integer :question_id
      t.string :question_answer
      t.string :student_answer
      t.boolean :is_correct

      t.timestamps
    end
  end
end
