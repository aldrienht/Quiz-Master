class Student::ExaminationsController < ApplicationController
  before_action :require_login, :authorize_student
  layout 'dashboard'

  def index
    @teachers = User.includes(:questions).all_teachers
  end

  def take_exam
    @teacher = User.find(params[:teacher_id])
    if @teacher
      @examinations = @teacher.get_student_remaining_exam_by_teacher(current_user)
      if @examinations.count <= 0
        redirect_to student_examinations_path, alert: 'You already finished the exam.'
      end
    end
  end

  def submit_exam
    begin
      params[:questions].each do |key, val|
        student_answer = val.try(:strip)
        question_id = key.to_i

        correct_answer = Question.find(question_id).answer
        res = ExamResult.new
        res.student_id = current_user.id
        res.teacher_id = params[:teacher]
        res.question_id = question_id
        res.question_answer = correct_answer
        res.student_answer = student_answer
        res.is_correct = ExamResult.matching_answers(correct_answer, student_answer)
        res.save!
      end

      redirect_to student_exam_results_path(params[:teacher])
    rescue => e
      redirect_to student_examinations_path, alert: e.message
    end
  end

  def exam_results
    @teacher = User.find(params[:teacher_id])
    @exam_results = current_user.exam_results.by_teacher(params[:teacher_id]).paginate(page: params[:page], per_page: 5)
  end

private
  def authorize_student
    # https://github.com/CanCanCommunity/cancancan/wiki/Non-RESTful-Controllers
    authorize! :student, :examinations
  end
end
