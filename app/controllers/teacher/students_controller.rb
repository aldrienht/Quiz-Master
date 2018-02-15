class Teacher::StudentsController < ApplicationController
  before_action :require_login
  layout 'dashboard'
  include ApplicationHelper

  def index
    authorize! :teacher, :students
    @students = User.all_students
  end

  def exam_results
    @teacher = current_user
    @student = User.find(params[:student_id])
    @exam_results = @student.exam_results.by_teacher(@teacher.id)
  end
end
