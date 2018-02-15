module FeatureLoginHelpers
  def sign_in(user)
    visit login_path
    expect(page).to have_content('Welcome Back! Please Sign In')

    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end
end
