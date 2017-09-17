require 'test_helper'

class DropboxControllerTest < ActionDispatch::IntegrationTest
  test "should get code" do
    get dropbox_code_url
    assert_response :success
  end

  test "should get list" do
    get dropbox_list_url
    assert_response :success
  end

  test "should get download" do
    get dropbox_download_url
    assert_response :success
  end

  test "should get upload" do
    get dropbox_upload_url
    assert_response :success
  end

end
