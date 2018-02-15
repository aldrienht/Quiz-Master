require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:user) }

  it 'should validate presence of required fields' do
    question = Question.new
    question.content = ''
    question.valid? # run validations
    expect(question.errors[:content]).to include("can't be blank") # check for presence of error

    question.answer = ''
    question.valid? # run validations
    expect(question.errors[:answer]).to include("can't be blank") # check for presence of error
  end

  it 'should filter result by published' do
    published_question = create(:question)
    unpublished_question = create(:another_question, {published: false})

    expect(Question.published).to include(published_question)
    expect(Question.published).not_to include(unpublished_question)
  end
end
