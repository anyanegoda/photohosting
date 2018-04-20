require 'test_helper'

class PhotosCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photos_comment = photos_comments(:one)
  end

  test "should get index" do
    get photos_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_photos_comment_url
    assert_response :success
  end

  test "should create photos_comment" do
    assert_difference('PhotosComment.count') do
      post photos_comments_url, params: { photos_comment: { body: @photos_comment.body } }
    end

    assert_redirected_to photos_comment_url(PhotosComment.last)
  end

  test "should show photos_comment" do
    get photos_comment_url(@photos_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_photos_comment_url(@photos_comment)
    assert_response :success
  end

  test "should update photos_comment" do
    patch photos_comment_url(@photos_comment), params: { photos_comment: { body: @photos_comment.body } }
    assert_redirected_to photos_comment_url(@photos_comment)
  end

  test "should destroy photos_comment" do
    assert_difference('PhotosComment.count', -1) do
      delete photos_comment_url(@photos_comment)
    end

    assert_redirected_to photos_comments_url
  end
end
