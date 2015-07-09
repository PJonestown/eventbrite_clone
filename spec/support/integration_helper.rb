module IntegrationHelper
  def sign_in(user)
    visit sign_in_path
    fill_in 'Username', with: user.username
    click_button 'Sign in'
  end
end
