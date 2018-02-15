class DashboardController < ApplicationController
  before_action :require_login
  layout 'dashboard'

  def index
  end
end
