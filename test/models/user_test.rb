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
end
