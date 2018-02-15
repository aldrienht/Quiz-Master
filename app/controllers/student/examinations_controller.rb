class Student::ExaminationsController < ApplicationController
  before_action :require_login
  layout 'dashboard'
  include ApplicationHelper

  def index
    # https://github.com/CanCanCommunity/cancancan/wiki/Non-RESTful-Controllers
    authorize! :student, :examinations
    @teachers = User.includes(:questions).all_teachers
  end

  def take_exam
    @teacher = User.find(params[:teacher_id])
    if @teacher
      @examinations = get_student_remaining_exam(@teacher)
      if @examinations.count <= 0
        redirect_to student_examinations_path, alert: 'You already finished the exam.' and return
      end
    end
  end

  def submit_exam
    begin
      params[:questions].each do |key, val|
        correct_answer = Question.find(key.to_i).answer
        ExamResult.create!(
          student_id: session[:user_id],
          teacher_id: params[:teacher],
          question_id: key.to_i,
          question_answer: correct_answer,
          student_answer: val,
          is_correct: check_answer(correct_answer, val)
        )
      end

      redirect_to student_exam_results_path(params[:teacher])
    rescue => e
      redirect_to student_examinations_path, alert: e.message
    end
  end

  def exam_results
    @teacher = User.find(params[:teacher_id])
    @exam_results = current_user.exam_results.by_teacher(params[:teacher_id])
  end
end
