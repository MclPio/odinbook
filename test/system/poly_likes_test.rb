require "application_system_test_case"

class PolyLikesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
  end

  test "should create PolyLike on comment" do
    user = users(:two)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"
    comment_id = comments(:one).id
    within("#comment_#{comment_id}") do
      click_on "Like"
      assert_text "1"
    end
  end

  test "should destroy PolyLike on comment" do
    user = users(:two)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"
    comment_id = comments(:one).id
    within("#comment_#{comment_id}") do
      click_on "Like"
    end

    within("#comment_#{comment_id}") do
      click_on "Unlike"
      assert_no_text "1 like"
    end
  end
end
