require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
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

  test "Sign in" do
    visit new_user_session_url
    assert_text "Log in"
    fill_in "Email", with: "normal@world.co"
    fill_in "Password", with: "password"
    click_on "Log in"
    assert_text "Signed in successfully"
  end

  test "Edit profile bio" do
    user = users(:normal)
    sign_in user
    visit user_path(user)
    click_on "Edit"
    fill_in "Username", with: "ab-normal"
    fill_in "Bio", with: "I like butterflies and cheese"
    fill_in "Avatar url", with: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg/250px-Eq_it-na_pizza-margherita_sep2005_sml.jpg"
    click_on "Save"
    assert_text "ab-normal"
    assert_text "I like butterflies and cheese"
    assert has_selector?("img[src^='https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg/250px-Eq_it-na_pizza-margherita_sep2005_sml.jpg']")
    take_screenshot
  end

  test "Can not input taken username" do
    user = users(:normal)
    sign_in user
    visit user_path(user)
    click_on "Edit"
    fill_in "Username", with: "normal2"
    click_on "Save"
    assert_text "Username has already been taken"
  end
end
