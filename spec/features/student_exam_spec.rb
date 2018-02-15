require "rails_helper"

RSpec.feature "Student Take Exam", :type => :feature do
  before do
    @teacher = create(:teacher)
    @student = create(:student)
    create(:question, {teacher_id: @teacher.id})
    create(:another_question, {teacher_id: @teacher.id})
    sign_in(@student)
  end

  it "can take exam and cannot retake it from listing" do
    # Take Exam
    click_link 'Examinations'
    expect(page).to have_content(@teacher.fullname)

    click_link 'Take Exam'
    fill_in 'questions_1', with: '5'
    fill_in 'questions_2', with: 'five'
    click_button 'Finish and Submit'

    expect(page).to have_content('Examination Result')
    expect(page).to have_content('Your Score: 2/2')

    # Should see the taken Exam status as 'Finishes'
    click_link 'Examinations'
    expect(page).to have_content('Finished')
    expect(page).to have_content('View Previous Exam Result')

    # Student try to re-access the url
    visit student_take_exam_path(@teacher.id)
    expect(page).to have_content('You already finished the exam.')
  end
end
