class SessionsController < ApplicationController
  def index
    redirect_to root_path
  end

  def new
    redirect_to dashboard_path if current_user && current_user.activated
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) && user.activated
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully logged in.'
      redirect_to dashboard_path
    else
      flash.now.alert = 'Invalid username or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: 'You have successfully logged out.'
  end
end
