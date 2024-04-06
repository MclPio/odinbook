require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  test "users can log in" do
    visit new_user_session_path
    fill_in "Email", with: users(:normal).email
    fill_in "Password", with: "password"
    click_button "Log in"
    assert_selector "button", text: "Sign out" 
  end

  test "users with invalid password denied log in" do
    visit new_user_session_path
    fill_in "Email", with: users(:normal).email
    fill_in "Password", with: "password3"
    click_button "Log in"
    assert_text "Invalid Email or password."
  end

  test "user can sign in with google oauth2" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new ({
      provider: 'google_oauth2',
      uid: '12345',
      info: {
        email: 'bob@world.co',
        first_name: 'bob',
        last_name: 'last',
        image: 'image_link'
      }
    })

    visit new_user_session_path
    click_button 'Continue with Google'
    assert_selector 'button', text: "Sign out"
  end

  test "user can fail sign in with google oauth2" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

    visit new_user_session_path
    click_button 'Continue with Google'
    take_screenshot
    assert_text 'Could not authenticate you from GoogleOauth2 because "Invalid credentials".'
  end
end
