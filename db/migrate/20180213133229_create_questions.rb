class CreateQuestions < ActiveRecord::Migration[5.1]
  def up
    create_table :questions do |t|
      t.text :content
      t.string :answer
      t.boolean :published

      t.timestamps
    end
  end

  def down
    drop_table :question
  end
end
