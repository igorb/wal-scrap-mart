# frozen_string_literal: true

class ProductsController < ApplicationController
  expose :products, (-> { Product.all.paginate(page: params[:page]) })
  expose :product

  def index
    respond_to do |format|
      format.html
      format.js {} # TODO: filter functionality
    end
  end

  def create
    build_product
    message = if product.save
                { success: 'Product has been created.' }
              else
                { error: "Can't parse url #{product.url}: #{product.errors.full_messages.join(', ')}" }
              end
    redirect_to root_path, turbolinks: true, flash: message
  end

  private

  def product_params
    params.require(:product).permit(:url, :name, :price)
  end

  def parsed_product
    @product ||= ::WalmartParser.new(product.url)
    @parsed_product ||= @product.parse

    @product
  end

  def build_product
    product.name = parsed_product.name
    product.price = parsed_product.price
    product.reviews.build(parsed_product.reviews.map { |review| { text: review } })
  end
end
