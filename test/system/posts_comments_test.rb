require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
  end

  test "should create Comment on Post" do
    user = users(:normal)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    fill_in "input", with: "A REPLY :3"
    click_on "Reply"

    expect(page).to have_content("A REPLY :3" )
  end

  test "should update Comment" do
    user = users(:normal)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    click_on "Edit"
    fill_in "comment_content", with: "A REPLY :3 edited"

    assert_text "Comment was successfully updated"
  end

  test "should destroy Comment" do
    user = users(:normal)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    click_on "Delete"

    assert_text "Comment was successfully deleted"
  end
end