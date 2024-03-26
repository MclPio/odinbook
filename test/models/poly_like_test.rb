require "test_helper"

class PolyLikeTest < ActiveSupport::TestCase
  test "can not duplicate likes" do
    user = users(:normal)
    post = posts(:one)

    user.poly_likes.create(likable_type: Post, likable_id: post.id)

    user.poly_likes.create(likable_type: Post, likable_id: post.id)

    assert(post.poly_likes.where(user_id: user.id).count == 1)
  end

  test "can like multiple items" do
    user = users(:normal)
    post_1 = posts(:one)
    comment_1 = comments(:one)
    post_2 = posts(:two)
    comment_2 = comments(:two)

    user.poly_likes.create(likable_type: Post, likable_id: post_1.id)

    user.poly_likes.create(likable_type: Comment, likable_id: comment_1.id)

    user.poly_likes.create(likable_type: Post, likable_id: post_2.id)

    user.poly_likes.create(likable_type: Comment, likable_id: comment_2.id)

    assert(user.poly_likes.count == 4)
  end
end
