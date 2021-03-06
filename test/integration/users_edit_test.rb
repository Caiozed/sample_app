require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:michael)
  	@other_user = users(:archer)
  end

  test "invalid profile update information" do
  	log_in_as(@user)
  	get edit_user_path(@user) 
  	assert_template 'users/edit'
  	patch user_path(@user), params:{user: {name: "",
  																				 email: "forbar@invalid",
  																				 password: "foo",
  																				 password_confirmation: "bar"}}
  	assert_template 'users/edit'
  	assert_not @user.errors.nil?  
  end

  test "Successful edit with friendly forwarding" do
  get edit_user_path(@user)
  log_in_as(@user)
  assert_redirected_to edit_user_path(@user)
  name  = "Foo Bar"
  email = "foo@bar.com"
  patch user_path(@user), params:{user:{name: name,
  																		 email: email,
  																		 password: "",
  																		 password_confirmation: ""}}
  assert_not flash.empty?
  assert_redirected_to user_path(@user)
  @user.reload
  assert_equal name, @user.name
  assert_equal email, @user.email
	end

	test "should use friendly redirect once" do
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		assert session[:forwarding_url].nil?
	end

	test"should redirect edit when not logged in" do
		get edit_user_path(@user)
		assert_not flash.empty?
		assert_redirected_to login_path
	end

	test "should redirect update when not logged in" do
		patch user_path(@user), params:{user:{name: @user.name,
																					email: @user.email}}
		assert_not flash.empty?
		assert_redirected_to login_path
	end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_user)
		get edit_user_path(@user)
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		log_in_as(@other_user)
		patch user_path(@user), params:{user:{name: @user.name,
																					email: @user.email}}
		assert flash.empty?
		assert_redirected_to root_url
	end
end
