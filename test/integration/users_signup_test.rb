require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'should not sign up user' do 
  	get signup_path
  	assert_no_difference 'User.count' do 
  		post signup_path, params: { user: { name: "", email: "user@invaid", password: "foo", password_confirmation: "bar"}}
  	end
  	assert_template 'users/new'
  	assert_select "div", "The form contains 4 errors" #assert_select 'div.error_explanation' also works
  end

  test 'should sign up user' do 
  	get signup_path 
  	assert_difference 'User.count', 1 do 
  		post signup_path, params: {user: {name: "Erickio", email: "erickio@io.com", password: "blablabla", password_confirmation: "blablabla"}}
  	end
  	follow_redirect!
  	assert_template 'users/show'
  	assert_not flash.empty?
  	assert is_logged_in?
  end
end
