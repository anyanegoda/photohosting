require 'test_helper'

class CollectionPhotoControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get collection_photo_create_url
    assert_response :success
  end

  test "should get delete" do
    get collection_photo_delete_url
    assert_response :success
  end

end
