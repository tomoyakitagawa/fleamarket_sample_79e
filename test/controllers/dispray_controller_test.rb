require 'test_helper'

class DisprayControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dispray_index_url
    assert_response :success
  end

end
