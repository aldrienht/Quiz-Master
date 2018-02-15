FactoryBot.define do
  factory :exam_result do
    association :student, factory: :student
    association :teacher, factory: :teacher
    association :question, factory: :question
    question_answer 'five'
    student_answer '5'
    is_correct true
	end

  factory :correct_answer_result, class: ExamResult do
    association :teacher, factory: :teacher
    association :question, factory: :question
    question_answer 'five'
    student_answer '5'
    is_correct true
  end

  factory :wrong_answer_result, class: ExamResult do
    association :teacher, factory: :teacher
    association :question, factory: :question
    question_answer 'five'
    student_answer '5'
    is_correct false
  end
end
