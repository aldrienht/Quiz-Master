class Question < ApplicationRecord
  belongs_to :user, foreign_key: "teacher_id", optional: true
  belongs_to :exam_result, optional: true
  validates_presence_of :content, :answer

  scope :published, -> { where(published: true) }
end
