require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should be directed to login" do
    get '/'
    assert_response :redirect
  end
end
