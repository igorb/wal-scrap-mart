# frozen_string_literal: true

class ProductsController < ApplicationController
  expose :products, -> { Product.all.paginate(page: params[:page]) }
  expose :product

  def index
    respond_to do |format|
      format.html
      format.js {}
    end
  end

  def create
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
end
