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

  describe 'compare teacher and student answer' do
    # matching_answers(teacher_answer, student_answer)

    it 'small and big letter should be ok' do
      expect(ExamResult.matching_answers('BIG', 'big')).to eq(true)
    end

    it 'number answer by student and words number by teacher should be ok' do
      expect(ExamResult.matching_answers('five', '5')).to eq(true)
    end

    it 'number answer by teacher and number words by student should be ok' do
      expect(ExamResult.matching_answers('5', 'five')).to eq(true)
    end

    it 'integer number answer by teacher and number words by student should be ok' do
      expect(ExamResult.matching_answers(5, 'five')).to eq(true)
    end

    it 'number answer by teacher and integer number by student should be ok' do
      expect(ExamResult.matching_answers('5', 5)).to eq(true)
    end

    it 'not equal string should not be correct' do
      expect(ExamResult.matching_answers('BIG', 'small')).to eq(false)
    end

    it 'not equal integer should not be correct' do
      expect(ExamResult.matching_answers('5', 3)).to eq(false)
    end
  end
end
