require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save user without username" do
    user = User.new
    user.email = 'bob@world.co'
    user.password = '123456'
    assert_not user.save, "User saved without username"
  end

  test "should not save user without email" do
    user = User.new
    user.username = 'bob'
    user.password = '123456'
    assert_not user.save, "User saved without email"
  end

  test "should not save user without password" do
    user = User.new
    user.email = 'bob@world.co'
    user.username = 'bob'
    assert_not user.save, "User saved without password"
  end

  # from 2.3.2 what an error looks like
  test "should report error" do
    assert_raises(NameError) do
      some_underfind_variable
    end
  end
end
