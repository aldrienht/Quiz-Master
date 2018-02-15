class Teacher::StudentsController < ApplicationController
  before_action :require_login, :authorize_teacher
  layout 'dashboard'
  include ApplicationHelper

  def index
    @students = User.all_students.paginate(page: params[:page], per_page: 5)
  end

  def exam_results
    @teacher = current_user
    @student = User.find(params[:student_id])
    @exam_results = @student.exam_results.by_teacher(@teacher.id).paginate(page: params[:page], per_page: 5)
  end

private
  def authorize_teacher
    authorize! :teacher, :students
  end
end
