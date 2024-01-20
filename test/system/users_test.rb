require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit users_url
  #
  #   assert_selector "h1", text: "Users"
  # end

  test "visiting sign in page" do
    visit new_user_session_url
    #take_screenshot #very cool feature!
    assert_selector "h2", text: "Log in"
  end

  # test "logging in via devise" do
  #   visit new_user_session_url
  #   fill_in "Email", with: "bob@world.co"
  #   fill_in "Password", with: "123456"
  #   click_on "Log in"
  # end

  test "visiting sign up page" do
    visit new_user_registration_url
    assert_selector "h2", text: "Sign up"
    assert_selector "label", text: "Username"
    assert_selector "label", text: "Email"
    assert_selector "label", text: "Password"
    assert_selector "label", text: "Password confirmation"
  end

  test "signing up" do
    visit new_user_registration_url
    fill_in "Username", with: "bob"
    fill_in "Email", with: "bob@world.co"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_on "Sign up"
    assert_text "Welcome! You have signed up successfully."
  end
end
