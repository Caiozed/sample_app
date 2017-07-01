require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "authenticated? should return false on user with nil remember digest" do
  	assert_not @user.authenticated?(:remember, "")
  end

  test "should destroy micropost associated with user" do
    @user.save
    @user.microposts.create!(content: "loren Ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end 
  end

  test "should follow and unfollow user" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end

  test "feed should have the right posts" do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)
    #posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    #posts from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    #posts form unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end

end
