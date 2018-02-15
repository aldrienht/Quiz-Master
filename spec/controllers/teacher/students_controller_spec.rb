require 'rails_helper'

RSpec.describe Teacher::StudentsController, type: :controller do

  describe "Teacher's Student pages requires login" do
    it "GET #index" do
      get :index
      expect(response).to redirect_to login_url
    end

    it "GET #exam_results" do
      @teacher = create(:teacher)
      @student = create(:student)

      process :exam_results, method: :get, params: {student_id: @student.id}
      expect(response).to redirect_to login_url
    end
  end
end
