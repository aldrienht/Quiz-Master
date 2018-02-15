module ApplicationHelper
  require 'humanize'

  def check_answer(teacher_answer, student_answer)
    checker(teacher_answer) == checker(student_answer)
  end

  def checker(param)
    if !!(param =~ /\A[-+]?[0-9]+\z/) || param.is_a?(Integer)
      # Check if teacher answer is string integer (e.g. '12'), since data type column is string
      # Convert string to integer and finally to human readable for comparison
      param = param.to_i.humanize
    else
      # Convert all to small letters and remove spaces for better comparison
      param = param.try(:downcase).strip
    end

    return param
  end

  def get_student_remaining_exam(teacher)
    # Get all finished_questions by student
    finished_questions = current_user.exam_results.pluck(:question_id)
    # Get all teacher's published questions by ID
    all_teacher_questions = teacher.questions.published.pluck(:id)
    # Remove finished questions and return unfinish ones
    unfinished_question_ids = all_teacher_questions.reject{|x| finished_questions.include?(x) }
    # Get all questions which has not been finished by student
    return unfinished_questions = Question.find(unfinished_question_ids)
  end
end
