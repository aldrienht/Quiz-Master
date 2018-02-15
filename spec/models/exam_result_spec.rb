require 'rails_helper'

RSpec.describe ExamResult, type: :model do
  it { should belong_to(:student).class_name('User') }
  it { should belong_to(:teacher).class_name('User') }
  it { should belong_to(:question) }

  it 'should filter by teacher' do
    teacher = create(:teacher)
    result = create(:exam_result, {teacher: teacher})

    expect(ExamResult.by_teacher(teacher.id)).to include(result)
  end

  it 'should filter by correct answer' do
    student = create(:student)
    correct = create(:correct_answer_result, {student: student})

    expect(ExamResult.correct).to include(correct)
  end

  it 'should filter wrong answer' do
    student = create(:student)
    wrong = create(:wrong_answer_result, {student: student})

    expect(ExamResult.wrong).to include(wrong)
  end
end
