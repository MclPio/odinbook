require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "can sign up" do
    visit new_user_registration_path
    fill_in "Username", with: 'joe'
    fill_in "Email", with: 'joe@world.co'
    fill_in "Password", with: '123456'
    fill_in "Password confirmation", with: '123456'
    click_button "Sign up"
    assert_selector "button", text: "Sign out"
    assert_text "Welcome! You have signed up successfully."
  end

  test "can not sign up with existing account" do
    visit new_user_registration_path
    fill_in "Username", with: users(:normal).username
    fill_in "Email", with: users(:normal).email
    fill_in "Password", with: '123456'
    fill_in "Password confirmation", with: '123456'
    click_button "Sign up"
    assert_text "Email has already been taken"
  end

  test "can sign up with google_oauth2" do
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

    visit root_path
    find('input[value="Login"]').click
    assert_selector 'button', text: "Sign out"
  end

  
end
