require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = users(:michael)
  	@other_user = users(:archer) 
  end

  test "should redirect idex when not logged in" do
  	get users_path
  	assert_redirected_to login_path
  end

  test "admin field is not editable" do
  	log_in_as(@other_user)
  	assert_not @other_user.admin?
  	patch user_path(@other_user), params: {user: { name: @other_user.name,
                                      email: @other_user.email,
																			admin: true}}
		assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when not logged in" do
  	assert_no_difference 'User.count' do
	  	delete user_path(@other_user)
  	end
  	assert_redirected_to login_path
  end

  test "should redirect destroy when logged in as a non-admin" do
  	log_in_as(@other_user)
  	assert_no_difference 'User.count' do
	  	delete user_path(@other_user)
  	end
  	assert_redirected_to root_path
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
