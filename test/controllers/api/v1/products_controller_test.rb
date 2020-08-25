require 'test_helper'

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should show product" do
    get api_v1_product_url(@product), as: :json
    json_response = JSON.parse(self.response.body)

    assert_response :success
    assert_equal @product.title, json_response["data"]["attributes"]["title"]
  end

  test "should show products" do
    get api_v1_products_url, as: :json
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post api_v1_products_url,
           params: { product: { title: @product.title, price: @product.price, published: @product.published } },
           headers: { Authorization: JsonWebToken.encode(user_id: @product.user_id) }, as: :json
    end
    assert_response :created
  end

  test "should forbid the creation of a product" do
    assert_no_difference("Product.count") do
      post api_v1_products_url,
           params: { product: { title: @product.title, price: @product.price, published: @product.published } }, as: :json
    end
    assert_response :forbidden
  end

  test "should update product" do
    patch api_v1_product_url(@product),
          params: { product: { title: @product.title } },
          headers: { Authorization: JsonWebToken.encode(user_id: @product.user_id) }, as: :json
    
    assert_response :success
  end

  test "should forbid product update" do
    patch api_v1_product_url(@product),
          params: { product: { title: @product.title } },
          headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) }, as: :json
    
    assert_response :forbidden
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete api_v1_product_url(@product), 
             headers: { Authorization: JsonWebToken.encode(user_id: @product.user_id) }, as: :json
    end
    assert_response :no_content
  end

  test "should forbid product delete" do
    assert_no_difference("Product.count", -1) do
      delete api_v1_product_url(@product),
            headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) }, as: :json
    end
    assert_response :forbidden
  end
end
