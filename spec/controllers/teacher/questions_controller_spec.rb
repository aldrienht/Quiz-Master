require 'rails_helper'

RSpec.describe Teacher::QuestionsController, type: :controller do
  let(:valid_attributes) { attributes_for(:question) }
  let(:invalid_attributes) {attributes_for(:invalid_question)}

  describe 'Question pages requires login' do
    it "GET #index" do
      get :index
      expect(response).to redirect_to login_url
    end

    it "GET #new" do
      get :new
      expect(response).to redirect_to login_url
    end
  end

  describe "GET #index & #new" do
    before do
      @teacher = create(:teacher)
      login_user(@teacher)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create with valid attributes" do
    before do
      @teacher = create(:teacher)
      login_user(@teacher)
    end

    it "redirects to teacher_questions_path" do
      process :create, method: :post, params: {question: valid_attributes}
      expect(response).to redirect_to(teacher_questions_path)
    end

    it "adds a new Question record" do
      expect{
             process :create, method: :post, params: {question: valid_attributes}
           }.to change(Question,:count).by(1)
    end
  end

  describe "POST #create with invalid attributes" do
    before do
      @teacher = create(:teacher)
      login_user(@teacher)
    end

    it "re-renders new template" do
      process :create, method: :post, params: {question: invalid_attributes}
      expect(response).to render_template :new
    end
  end

  # describe "GET #destroy" do
  #   before do
  #     @teacher = create(:teacher)
  #     @question = create(:question, {teacher_id: @teacher.id})
  #     login_user(@teacher)
  #   end
  #
  #   it "redirects to teacher_questions_path" do
  #     expect{
  #       delete :destroy, :id => @question
  #    }.to change(Question, :count).by(-1)
  #   end
  # end

end
