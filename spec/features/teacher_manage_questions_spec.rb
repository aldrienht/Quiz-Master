require "rails_helper"

RSpec.feature "Teacher Manage Question", :type => :feature do
  before do
    @teacher = create(:teacher)
    create(:question, {teacher_id: @teacher.id})
    sign_in(@teacher)
    click_link 'Questions Management'
    expect(page).to have_content('Listing Questions')
  end

  it "can create question" do
    click_link 'New Question'
    fill_in 'question_content', with: 'New question for student'
    fill_in 'question_answer', with: 'new_username'
    check 'question_published'
    click_button 'Create Question'

    expect(page).to have_content('Question was successfully created.')
  end

  it "can edit question" do
    click_link 'Edit'
    expect(page).to have_content('Editing Question')
    fill_in 'question_content', with: 'Updated question for student'
    fill_in 'question_answer', with: 'updated_username'
    click_button 'Update Question'

    expect(page).to have_content('Question was successfully updated.')
    expect(page).to have_content('Updated question for student')
  end

  it "validates blank content" do
    click_link 'New Question'
    fill_in 'question_content', with: ''
    fill_in 'question_answer', with: 'answer'
    check 'question_published'
    click_button 'Create Question'

    expect(page).to have_content("Content can't be blank")
  end

  it "validates blank answer" do
    click_link 'New Question'
    fill_in 'question_content', with: 'New content'
    fill_in 'question_answer', with: ''
    check 'question_published'
    click_button 'Create Question'

    expect(page).to have_content("Answer can't be blank")
  end

  it "can delete his created question" do
    click_link 'Delete'
    # save_and_open_page
    expect(page).to have_content('Question was successfully destroyed.')
  end
end
