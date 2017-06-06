require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
  	assert_no_difference 'User.count' do
  		post signup_path, params: {user: {name: "",
  																		email: "user@invalid",
  																		password: "foo",
  																		password_confirmation: "bar"}}
  	end
  	assert_template 'users/new'
  	assert_select 'div#error_explanation'
	end

	test "Valid sigup information" do
		assert_difference "User.count",1 do
			post signup_path, params: {user: {name: "Exemple user",
																			 email: "user@exemple.com",
																			 password: "password",
																			 password_confirmation: "password"}}
		end
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
	end
end

