require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
  end

  test "should create Comment on Post" do
    user = users(:two)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    fill_in "comment[body]", with: "A REPLY :3"

    click_on "submit"
    assert_text "A REPLY :3"
  end

  test "should update Comment" do
    user = users(:one)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    click_on "Edit"
    fill_in "[comment][body]", with: "A REPLY :3 edited"
    click_on "Save"
    assert_text "Comment was successfully updated."
    assert_text "A REPLY :3 edited"
  end

  test "should destroy Comment" do
    user = users(:one)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"
    click_on "Delete"
    accept_alert("Are you sure?")
    assert_text "Comment was successfully deleted"
  end
end