require "rails_helper"

RSpec.feature "User page access ability", :type => :feature do
  context 'Validates Ability Access' do
    before do
      @admin = create(:admin)
      @teacher = create(:teacher)
      @student = create(:student)
    end

    # ADMIN ROLE
    it "Admin tries to access Student pages" do
      sign_in(@admin)
      visit student_examinations_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit student_take_exam_path(@teacher.id)
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit student_exam_results_path(@teacher.id)
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')
    end

    it "Admin tries to access Teacher pages" do
      sign_in(@admin)
      visit teacher_questions_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit teacher_student_exam_results_path(@student.id)
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit teacher_students_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')
    end

    # TEACHER ROLE
    it "Teacher tries to access Admin pages" do
      sign_in(@teacher)
      visit admin_users_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit new_admin_user_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')
    end

    it "Teacher tries to access Student pages" do
      sign_in(@teacher)

      visit student_take_exam_path(@teacher.id)
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit student_exam_results_path(@teacher.id)
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')
    end

    # STUDENT ROLE
    it "Student tries to access Admin pages" do
      sign_in(@student)
      visit admin_users_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit new_admin_user_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')
    end

    it "Student tries to access Teacher pages" do
      sign_in(@student)
      visit teacher_questions_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit teacher_student_exam_results_path(@student.id)
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')

      visit teacher_students_path
      expect(page).to have_content('You are NOT AUTHORIZED to access that page.')
    end
  end
end
