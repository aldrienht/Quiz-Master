class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if !current_user
      flash[:error] = "You need to be logged in to get to that page."
      redirect_to login_path and return
    end
  end

  def allow_only_teachers
    if !current_user.is_teacher?
      flash[:error] = "You're not allowed to view that page."
      redirect_to root_url
    end
  end

  def allow_admins_only
    if !current_user.is_admin?
      flash[:error] = "You're not allowed to view that page."
      redirect_to root_url
    end
  end

  helper_method :current_user
end
