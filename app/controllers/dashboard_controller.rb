class DashboardController < ApplicationController
  before_action :require_login
  # , :allow_only_teachers, :allow_only_admins
  layout 'admin_teacher'

  def index
  end
end
