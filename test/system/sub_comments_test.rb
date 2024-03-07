require "application_system_test_case"

class SubCommentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
  end

  test "should create sub-comment" do
    user = users(:two)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    comment_id = comments(:one).id
    within("#comment_#{comment_id}") do
      click_on "Reply"
      fill_in "comment[body]", with: "This is a child comment"
      click_on "Submit"
    end
    assert_text "This is a child comment"
  end

  test "should update sub-comment" do
    user = users(:two)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    comment_id = comments(:one).id
    within("#comment_#{comment_id}") do
      click_on "Reply"
      fill_in "comment[body]", with: "This is a child comment"
      click_on "Submit"
      click_on "Edit"
    end
    fill_in "_comment_body", with: "This is an edited child comment"
    click_on "Save"
    assert_text "This is an edited child comment"
  end

  test "should delete sub-comment" do
    user = users(:two)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    comment_id = comments(:one).id
    within("#comment_#{comment_id}") do
      click_on "Reply"
      fill_in "comment[body]", with: "This is a child comment"
      click_on "Submit"
      click_on "Delete"
      accept_confirm("Are you sure?")
    end
    assert_no_text "This is a child comment"
    assert_text "Comment was successfully deleted."
  end
end
