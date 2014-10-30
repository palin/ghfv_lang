require 'test_helper'

class GithubApiControllerTest < ActionController::TestCase
  test "should find existing user" do
    get_find user: { name: 'dhh' }

    assert_response :success
    assert_not_nil assigns(:language)
    assert_not_nil assigns(:user_name)
  end

  test "should redirect to homepage if github error" do
    get_find user: { name: nil }

    assert_response :redirect
    assert flash.alert.present?
  end

  test "should redirect to homepage if error with params" do
    get_find

    assert_response :redirect
    assert flash.alert.present?
  end

  private

  def get_find(params = nil)
    get :find, params
  end
end
