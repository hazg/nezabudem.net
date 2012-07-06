require 'test_helper'

class PlacePhotosControllerTest < ActionController::TestCase
  setup do
    @place_photo = place_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:place_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create place_photo" do
    assert_difference('PlacePhoto.count') do
      post :create, place_photo: @place_photo.attributes
    end

    assert_redirected_to photo_path(assigns(:place_photo))
  end

  test "should show place_photo" do
    get :show, id: @place_photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @place_photo
    assert_response :success
  end

  test "should update place_photo" do
    put :update, id: @place_photo, place_photo: @place_photo.attributes
    assert_redirected_to place_photo_path(assigns(:place_photo))
  end

  test "should destroy place_photo" do
    assert_difference('PlacePhoto.count', -1) do
      delete :destroy, id: @place_photo
    end

    assert_redirected_to place_photos_path
  end
end
