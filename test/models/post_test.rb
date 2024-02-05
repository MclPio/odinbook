require "test_helper"

class PostTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  test "users can create posts" do
    user = users(:normal)
    sign_in user
    user.posts.new(title: 'first post', body: 'post text').save
    assert(user.posts.first.title == 'first post')
    assert(user.posts.first.body == 'post text')
  end
end


# Most features in most Rails applications are, for better or worse, some slight variation on CRUD operations. Here are the tests I almost always write for every CRUD feature.

#     Creating a record with valid inputs
#     Trying to create a record with invalid inputs
#     Updating a record

# Let me go into detail on each one of these. For each test case, let’s imagine we’re working with a resource called Location.