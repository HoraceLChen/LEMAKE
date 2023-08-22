require "test_helper"

class UploadedIngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uploaded_ingredients_index_url
    assert_response :success
  end

  test "should get create" do
    get uploaded_ingredients_create_url
    assert_response :success
  end

  test "should get update" do
    get uploaded_ingredients_update_url
    assert_response :success
  end
end
