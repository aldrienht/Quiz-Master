class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_url, alert: 'You are NOT AUTHORIZED to access that page.' }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if !current_user
      flash[:error] = "You need to be logged in to get to that page."
      redirect_to login_path and return
    end
  end

  helper_method :current_user
  private

  def current_ability
    # I am sure there is a slicker way to capture the controller namespace
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    # Ability.new(current_user, controller_namespace)
    @current_ability ||= Ability.new(current_user, controller_namespace)

  end
end
