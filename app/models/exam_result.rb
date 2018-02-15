class ExamResult < ApplicationRecord
  belongs_to :student, foreign_key: 'student_id', class_name: 'User'
  belongs_to :teacher, foreign_key: 'teacher_id', class_name: 'User'
  belongs_to :question

  scope :by_teacher, -> (id) { where(teacher_id: id) if id.present? }
  scope :correct, -> { where(is_correct: true) }
  scope :wrong, -> { where(is_correct: false) }
end
