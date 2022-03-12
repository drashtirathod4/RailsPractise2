class ProductsController < ApplicationController
    load_and_authorize_resource
    before_action :auth_admin, except: [:show]
    before_action :authenticate_user!
    before_action :get_user
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    # GET	/products
    def index
        @products = @user.products
    end

    # GET	/products/1
    def show
        @product = Product.find(params[:id])
    end

    # GET	/products/new
    def new
        @product = @user.products.build
    end

    # POST /products
    def create
        product = @user.products.create(product_params)
        if product.valid?
            redirect_to products_path
        else 
            flash[:errors] = product.errors.full_messages
            redirect_to new_product_path
        end
    end

    # GET	/products/1/edit
    def edit
        @product = Product.find(params[:id])
    end

    # PATCH/PUT	/products/1
    def update 
        @product = Product.find(params[:id])
        @product.update(product_params)
        if @product.valid?
            redirect_to product_path
        else 
            flash[:errors] = @product.errors.full_messages
            redirect_to edit_product_path(@product)
        end
    end

    # DELETE	/products/1
    def destroy 
        @product = Product.find(params[:id])
        @product.destroy 
        redirect_to products_path
    end

    private 
    def get_user
        @user = current_user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
        if @user.role == "Admin"
            @product = @user.products.find(params[:id])
        else
            @product = Product.find(params[:id])
        end
    end

    def product_params
        params.require(:product).permit(:name, :description, :price, :user_id)
    end
end
