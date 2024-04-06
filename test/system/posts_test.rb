require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    user = users(:normal)
    sign_in user

    visit posts_url
    assert_selector :button, "Post"
  end

  test "should create post" do
    user = users(:normal)
    sign_in user

    visit posts_url

    fill_in "post[body]", with: @post.body
    click_on "Post"

    assert_text "Post was successfully created"
  end

  test "should update Post" do
    user = users(:one)
    sign_in user

    visit post_url(@post)
    click_on "Edit this post", match: :first

    fill_in "post[body]", with: @post.body
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "should destroy Post" do
    user = users(:one)
    sign_in user

    visit post_url(@post)
    click_on "Destroy this post", match: :first

    assert_text "Post was successfully destroyed"
  end
end
