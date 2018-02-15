module SpecLoginHelper
  def login_user(user)
    user = User.where(:username => user.username).first
    request.session[:user_id] = user.id
    request.session[:username] = user.username
  end

  def current_user
    User.find(request.session[:user_id])
  end
end
