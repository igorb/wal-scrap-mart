require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let!(:product) { create(:product) }
  let!(:products) { create_list(:product, 3) }
  let(:product_attributes) { attributes_for(:product) }
  let(:product_invalid_attributes) { attributes_for(:product, url: '') }

  describe 'GET index' do
    it 'assigns @products' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(subject.products.count).to eq 4
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new product' do
        expect{ post :create, params: { product: product_attributes } }.to change(Product, :count).by(1)
      end

      it 'redirects to product list' do
        post :create, params: { product: product_attributes }
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new product' do
        expect{ post :create, params: { product: product_invalid_attributes }}.to_not change(Product, :count)
      end

      it 're-renders the new method' do
        post :create, params: { product: product_invalid_attributes }
        expect(response).to redirect_to root_path
      end
    end
  end
end
