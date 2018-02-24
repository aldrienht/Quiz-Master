require 'humanize'
class ExamResult < ApplicationRecord
  belongs_to :student, foreign_key: 'student_id', class_name: 'User'
  belongs_to :teacher, foreign_key: 'teacher_id', class_name: 'User'
  belongs_to :question

  default_scope { order(created_at: :desc) }
  scope :by_teacher, -> (id) { where(teacher_id: id) if id.present? }
  scope :correct, -> { where(is_correct: true) }
  scope :wrong, -> { where(is_correct: false) }

  class << self
    def matching_answers(teacher_answer, student_answer)
      checker(teacher_answer) == checker(student_answer)
    end

    def checker(answer)
      return nil if answer.nil? || answer.blank?

      if !!(answer =~ /\A[-+]?[0-9]+\z/) || answer.is_a?(Integer)
        # Check if teacher answer is string integer (e.g. '12'), since data type column is string
        # Convert string to integer and finally to human readable for comparison
        answer = answer.to_i.humanize
      else
        # Convert all to small letters and remove spaces for better comparison
        answer = answer.try(:downcase)
      end

      return answer
    end
  end
end
