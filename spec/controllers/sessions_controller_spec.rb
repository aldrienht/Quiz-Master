# require 'rails_helper'
#
# RSpec.describe SessionsController, type: :controller do
#
#   let(:password) {"password4321"}
#   let(:user) do
#     u = create(:admin)
#     u.update_attributes(password: password, password_confirmation: password)
#     u
#   end
#   let(:valid_session) { login_user(user) }
#
#   describe "GET #new" do
#     it "returns http success" do
#       get :new
#       expect(response).to have_http_status(:success)
#     end
#   end
#
#   describe "POST #create" do
#     it "redirects to dashboards_path" do
#       process :create, method: :post, params: {user: {email: user.email, password: password}}
#       expect(response).to redirect_to(dashboards_path)
#     end
#   end
#
#   describe "GET #destroy" do
#     it "redirects to login_path" do
#       process :destroy, method: :delete, params: {}
#       expect(response).to redirect_to(login_path)
#     end
#   end
#
#
# end
