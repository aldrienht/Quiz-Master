require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  it "cannot GET #index" do
    get :index
    expect(response).to redirect_to login_url
  end

  it "GET #index" do
    login_user(create(:student))

    get :index
    expect(response).to have_http_status(:success)
  end
end
