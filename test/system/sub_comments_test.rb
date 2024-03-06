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
      fill_in "Body", with: "This is a child comment"
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
      fill_in "Body", with: "This is a child comment"
      click_on "Submit"
      # find sub comment
      # click on edit
      # fill in Child comment edited!
      # click on submit
      # assert that the subcomment is updated
    end
  end

  test "should delete sub-comment" do
    user = users(:two)
    sign_in user

    visit post_path(@post)
    assert_selector "p", text: "This is a post's text content"

    comment_id = comments(:one).id
    within("#comment_#{comment_id}") do
      click_on "Reply"
      fill_in "Body", with: "This is a child comment"
      click_on "Submit"
      # click on delete
      # say yes to popup
      # assert comment is deleted or notice confirming deletion
    end
  end
end
