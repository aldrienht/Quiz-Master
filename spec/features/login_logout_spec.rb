require "rails_helper"

RSpec.feature "All User Type Login and Logout", :type => :feature do
  it "goes to dashboard page after Admin's successful login" do
    @admin = create(:admin)

    visit "/login"
    expect(page).to have_content('Welcome Back! Please Sign In')

    fill_in "Username", :with => @admin.username
    fill_in "Password", :with => @admin.password
    click_button "Log In"

    expect(page).to have_content('Welcome to Quiz Master')
    expect(page).to have_content('User Management')
    expect(page).to have_no_content('Questions Management')
    expect(page).to have_no_content('My Students')
  end

  it "goes to dashboard page after Teacher's successful login" do
    @teacher = create(:teacher)

    visit "/login"
    expect(page).to have_content('Welcome Back! Please Sign In')

    fill_in "Username", :with => @teacher.username
    fill_in "Password", :with => @teacher.password
    click_button "Log In"

    expect(page).to have_content('Welcome to Quiz Master')
    expect(page).to have_content('Questions Management')
    expect(page).to have_content('My Students')
    expect(page).to have_no_content('User Management')
  end

  it "goes to dashboard page after Student's successful login" do
    @student = create(:student)

    visit "/login"
    expect(page).to have_content('Welcome Back! Please Sign In')

    fill_in "Username", :with => @student.username
    fill_in "Password", :with => @student.password
    click_button "Log In"

    expect(page).to have_content('Welcome to Quiz Master')
    expect(page).to have_content('Examinations')
    expect(page).to have_no_content('Questions Management')
    expect(page).to have_no_content('My Students')
    expect(page).to have_no_content('User Management')
  end

  it "will show error message when invalid login" do
    visit "/login"
    expect(page).to have_content('Welcome Back! Please Sign In')

    fill_in "Username", :with => 'wrong username'
    fill_in "Password", :with => 'invalid password'
    click_button "Log In"

    expect(page).to have_content('Invalid username or password.')
  end

  it "will show error message when user is deactivated" do
    @deactivated_user = create(:in_active_user)

    visit "/login"
    expect(page).to have_content('Welcome Back! Please Sign In')

    fill_in "Username", :with => @deactivated_user.username
    fill_in "Password", :with => @deactivated_user.password
    click_button "Log In"

    expect(page).to have_content('Invalid username or password.')
  end
end

# ALIASES

# feature == describe
# :type => :feature
# background == before
# scenario == it
# given/given! == let/let!
