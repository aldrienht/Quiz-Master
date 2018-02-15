class Teacher::QuestionsController < ApplicationController
  before_action :require_login
  load_and_authorize_resource
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # GET /teacher/questions
  # GET /teacher/questions.json
  def index
    @questions = current_user.questions
  end

  # GET /teacher/questions/1
  # GET /teacher/questions/1.json
  def show
  end

  # GET /teacher/questions/new
  def new
    @question = Question.new
  end

  # GET /teacher/questions/1/edit
  def edit
  end

  # POST /teacher/questions
  # POST /teacher/questions.json
  def create
    @question = Question.new(question_params)
    @question.teacher_id = session[:user_id]

    respond_to do |format|
      if @question.save
        format.html { redirect_to teacher_questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teacher/questions/1
  # PATCH/PUT /teacher/questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to teacher_questions_path, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/questions/1
  # DELETE /teacher/questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to teacher_questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :answer, :published)
    end
end
