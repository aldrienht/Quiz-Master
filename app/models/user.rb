class User < ApplicationRecord
  has_many :questions, foreign_key: 'teacher_id', class_name: 'Question', dependent: :destroy
  has_many :exam_results, foreign_key: 'student_id', class_name: 'ExamResult', dependent: :destroy

  validates_uniqueness_of :fullname, message: "must be unique!"
  validates_uniqueness_of :username, message: "must be unique!"
  validates_uniqueness_of :email, message: "must be unique!"

  validates_presence_of :fullname, :username, :email, :role
  validates_format_of :email, :with => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}\Z/i

  has_secure_password

  scope :all_teachers, -> { where(role: 'teacher') }
  scope :all_students, -> { where(role: 'student') }

  def is_admin?
    self.role == 'admin'
  end

  def is_student?
    self.role == 'student'
  end

  def is_teacher?
    self.role == 'teacher'
  end

  def get_student_remaining_exam_by_teacher(student)
    # Get all finished_questions by student
    finished_questions = student.exam_results.pluck(:question_id)
    # Get all teacher's published questions by ID
    all_teacher_questions = self.questions.published.pluck(:id)
    # Remove finished questions and return unfinish ones
    unfinished_question_ids = all_teacher_questions.reject{|x| finished_questions.include?(x) }
    # Get all questions which has not been finished by student
    return unfinished_questions = Question.find(unfinished_question_ids)
  end
end
