class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[destroy show update]
  before_action :check_login, only: :create
  before_action :check_owner, only: %i[destroy update]

  def show
    render json: ProductSerializer.new(@product).serializable_hash
  end

  def index
    @products = Product.all
    render json: ProductSerializer.new(@products).serializable_hash
  end

  def create
    product = current_user.products.build(product_params)

    if product.save
      render json: ProductSerializer.new(product).serializable_hash, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: ProductSerializer.new(@product).serializable_hash
    else
      render json: @product.errors, status: :unprocessable_entity 
    end
  end

  def destroy
    @product.destroy
    head 204
  end

  private

    def check_owner
      head :forbidden unless @product.user_id == current_user&.id
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :price, :published)
    end
end
