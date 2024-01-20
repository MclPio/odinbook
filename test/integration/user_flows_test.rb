require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can see the log in page" do
    get "/"
    assert_select "h1", "Odinbook"
  end

  test "can create account" do
    get "/users/sign_up"
    assert_response :success

    post "/users",
      params: {"authenticity_token"=>"[FILTERED]", "user"=>{"username"=>"key", 
      "email"=>"key@world.co", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, 
      "commit"=>"Sign up"}
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_select "p", "Welcome! You have signed up successfully."
  end
end
