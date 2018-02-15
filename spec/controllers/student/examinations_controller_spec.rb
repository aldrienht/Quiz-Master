require 'rails_helper'

RSpec.describe Student::ExaminationsController, type: :controller do

  describe 'Examination pages requires login' do
    it "GET #index" do
      get :index
      expect(response).to redirect_to login_url
    end

    it "GET #take_exam" do
      teacher = create(:teacher)
      process :take_exam, method: :get, params: {teacher_id: teacher.id}
      expect(response).to redirect_to login_url
    end
    
    it "GET #exam_results" do
      teacher = create(:teacher)
      process :exam_results, method: :get, params: {teacher_id: teacher.id}
      expect(response).to redirect_to login_url
    end
  end

  describe "Can access pages" do
    before do
      @teacher = create(:teacher)
      @student = create(:student)
      login_user(@student)
    end

    it "returns http success #index" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success #take_exam" do
      @question = create(:question, {teacher_id: @teacher.id})
      @another_question = create(:another_question, {teacher_id: @teacher.id})

      process :take_exam, method: :get, params: {teacher_id: @teacher.id}
      expect(response).to have_http_status(:success)
    end

    it "returns http success #exam_results" do
      process :exam_results, method: :get, params: {teacher_id: @teacher.id, page: 1}
      expect(response).to have_http_status(:success)
    end

    it "redirect_to student_exam_results_path after successful submission" do
      @question = create(:question, {teacher_id: @teacher.id})
      @another_question = create(:another_question, {teacher_id: @teacher.id})
      process :submit_exam, method: :post, params: {
        questions: ["#{@question.id}", "#{@another_question.id}"],
        teacher: @teacher.id
      }
      expect(response).to redirect_to student_exam_results_path(@teacher.id)
    end
  end
end
