require "rails_helper"

RSpec.feature "Teacher Can View Student Exam Result", :type => :feature do
  before do
    @exam_result = create(:exam_result)
    create(:question, {teacher_id: @exam_result.teacher.id})
    sign_in(@exam_result.teacher)
  end

  it 'can view all students' do
    click_link 'My Students'
    expect(page).to have_content('Listing My Students')
    expect(page).to have_content(@exam_result.student.fullname)
    expect(page).to have_content(@exam_result.student.email)
    click_link 'View Previous Exam Result'

    expect(page).to have_content('Examination Result')
    expect(page).to have_content('Student Score: 1/1')
    expect(page).to have_content("Student: #{@exam_result.student.fullname}")
  end
end
