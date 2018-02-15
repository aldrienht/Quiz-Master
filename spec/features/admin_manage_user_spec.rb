require "rails_helper"

RSpec.feature "Admin Manage User", :type => :feature do
  before do
    @admin = create(:admin)
    sign_in(@admin)
    click_link 'User Management'
    expect(page).to have_content('Listing Users')
  end

  it "can create user" do
    click_link 'New User'
    fill_in 'user_fullname', with: 'New Fullname'
    fill_in 'user_username', with: 'new_username'
    fill_in 'user_email', with: 'new@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content('User was successfully created.')
  end

  it "can edit user" do
    click_link 'Edit'
    expect(page).to have_content('Editing User')
    fill_in 'user_fullname', with: 'Updated Fullname'
    fill_in 'user_username', with: 'updated_username'
    click_button 'Update User'

    expect(page).to have_content('User was successfully updated.')
    expect(page).to have_content('Updated Fullname')
  end

  it "validates blank fullname" do
    click_link 'New User'
    fill_in 'user_fullname', with: ''
    fill_in 'user_username', with: 'new_username'
    fill_in 'user_email', with: 'new@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Fullname can't be blank")
  end

  it "validates unique fullname" do
    click_link 'New User'
    fill_in 'user_fullname', with: @admin.fullname
    fill_in 'user_username', with: 'new_username'
    fill_in 'user_email', with: 'new@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Fullname must be unique!")
  end

  it "validates blank username" do
    click_link 'New User'
    fill_in 'user_fullname', with: ''
    fill_in 'user_username', with: ''
    fill_in 'user_email', with: 'new@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Username can't be blank")
  end

  it "validates unique username" do
    click_link 'New User'
    fill_in 'user_fullname', with: ''
    fill_in 'user_username', with: @admin.username
    fill_in 'user_email', with: 'new@gmail.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Username must be unique!")
  end

  it "validates blank email" do
    click_link 'New User'
    fill_in 'user_fullname', with: 'Fullname'
    fill_in 'user_username', with: 'Username'
    fill_in 'user_email', with: ''
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Email can't be blank")
  end

  it "validates invalid format email" do
    click_link 'New User'
    fill_in 'user_fullname', with: 'Fullname'
    fill_in 'user_username', with: 'new_username'
    fill_in 'user_email', with: 'invalid-email.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Email is invalid")
  end

  it "validates blank password" do
    click_link 'New User'
    fill_in 'user_fullname', with: 'Fullname'
    fill_in 'user_username', with: 'new_username'
    fill_in 'user_email', with: 'good@email.com'
    fill_in 'user_password', with: ''
    fill_in 'user_password_confirmation', with: 'password'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Password can't be blank")
  end

  it "validates not matched password & confirmation" do
    click_link 'New User'
    fill_in 'user_fullname', with: 'Fullname'
    fill_in 'user_username', with: 'new_username'
    fill_in 'user_email', with: 'good@email.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'not matched'
    select 'Teacher', from: 'user_role'
    check 'user_activated'
    click_button 'Create User'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
