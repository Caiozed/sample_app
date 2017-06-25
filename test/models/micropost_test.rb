require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
  	@user =  users(:michael)
  	@micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should bre valid" do
  	assert @micropost.valid?
  end

  test "user id should be present" do
  	@micropost.user_id = nil
  	assert_not @micropost.valid?
  end

  test "content should be present" do
  	@micropost.content = "   "
  	assert_not @micropost.valid?
  end

  test "content should be less tha 141 characters" do
  	@micropost.content = "a" * 141
  	assert_not @micropost.valid?
	end  	

	test "should return most recent post first" do
		assert_equal microposts(:most_recent), Micropost.first
	end	
end
