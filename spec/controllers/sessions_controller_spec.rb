require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context "will handle actions" do
    let(:user) do
      @admin = create(:admin)
      login_user(@admin)
      @admin
    end

    it "GET #index" do
      get :index
      expect(response).to redirect_to root_path
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #create" do
      it "redirects to dashboard_path" do
        process :create, method: :post, params: {username: user.username, password: user.password}
        expect(response).to redirect_to(dashboard_path)
      end
    end

    describe "GET #destroy" do
      it "redirects to new_session_path" do
        process :destroy, method: :delete, params: {}
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end

# ALIASES

# feature == describe
# :type => :feature
# background == before
# scenario == it
# given/given! == let/let!
