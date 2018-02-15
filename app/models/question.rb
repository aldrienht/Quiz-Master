class Question < ApplicationRecord
  belongs_to :user, foreign_key: "teacher_id", optional: true
  has_one :exam_result
  validates_presence_of :content, :answer

  default_scope { order(created_at: :desc) }
  scope :published, -> { where(published: true) }

  before_save :trim_answer

  def trim_answer
    self.answer = self.answer.strip unless self.answer.nil?
  end
end
