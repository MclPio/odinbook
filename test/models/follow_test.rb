require "test_helper"

class FollowTest < ActiveSupport::TestCase
  test 'follower can follow others' do
    follow = Follow.new(follower_id: User.first.id, followee_id: User.second.id)
    assert follow.valid?
  end

  test 'follower can not follow twice' do
    follow1 = Follow.new(follower_id: User.first.id, followee_id: User.second.id)
    follow1.save
    follow2 = Follow.new(follower_id: User.first.id, followee_id: User.second.id)
    assert_not follow2.valid?
  end

  test 'follower can not follow themsevles' do
    follow = Follow.new(follower_id: User.first.id, followee_id: User.first.id)
    assert_not follow.valid?
  end

  test 'followee can approve requests' do
    follow = Follow.new(follower_id: User.first.id, followee_id: User.second.id)
    follow.toggle(:approved).save
    assert follow.approved == true
  end
end
