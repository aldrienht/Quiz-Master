require 'rails_helper'
require 'admin/users_controller'

RSpec.describe Admin::UsersController, type: :controller do
  let(:valid_attributes) { attributes_for(:student) }
  let(:invalid_attributes) {attributes_for(:invalid_user)}

  describe 'Admin pages requires login' do
    it "GET #index" do
      get :index
      expect(response).to redirect_to login_url
    end

    it "GET #new" do
      get :new
      expect(response).to redirect_to login_url
    end
  end

  describe "GET #index & #new" do
    before do
      @admin = create(:admin)
      login_user(@admin)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create with valid attributes" do
    before do
      @admin = create(:admin)
      login_user(@admin)
    end

    it "redirects to admin_users_path" do
      process :create, method: :post, params: {user: valid_attributes}
      expect(response).to redirect_to(admin_users_path)
    end

    it "adds a new User record" do
      expect{
             process :create, method: :post, params: {user: valid_attributes}
           }.to change(User,:count).by(1)
    end
  end

  describe "POST #create with invalid attributes" do
    before do
      @admin = create(:admin)
      login_user(@admin)
    end

    it "re-renders new template" do
      process :create, method: :post, params: {user: invalid_attributes}
      expect(response).to render_template :new
    end
  end

  # describe "GET #destroy" do
  #   before do
  #     @admin = create(:admin)
  #     @student = create(:student)
  #     login_user(@admin)
  #   end
  #
  #   it "redirects to admin_users_path" do
  #     expect{
  #       delete :destroy, :id => @admin, :user => {:password => @admin.password}
  #    }.to change(User, :count).by(-1)
  #   end
  # end

end
