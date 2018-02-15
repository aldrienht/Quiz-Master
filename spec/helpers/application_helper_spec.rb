require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'compare teacher and student answer' do
    # check_answer(teacher_answer, student_answer)

    it 'small and big letter should be ok' do
      expect(helper.check_answer('BIG', 'big')).to eq(true)
    end

    it 'number answer by student and words number by teacher should be ok' do
      expect(helper.check_answer('five', '5')).to eq(true)
    end

    it 'number answer by teacher and number words by student should be ok' do
      expect(helper.check_answer('5', 'five')).to eq(true)
    end
  end
end
