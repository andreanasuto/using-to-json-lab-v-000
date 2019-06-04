class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def inventory
    product = Product.find(params[:id])
    render plain: product.inventory > 0 ? true : false
  end

  def description
    product = Product.find(params[:id])
    render plain: product.description
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
    redirect_to products_path
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
     format.html { render :show }
     format.json { render :json => @product.to_json(
       :only => [:id, :name, :description, :inventory, :price]
       )}
   end
  end

# e.g.
# nominee.to_json(
#  only: [:id, :first_name, :email, :phone],
#  methods: [:last_three_of_email]
# )

#Only include the product id, name, description, inventory and price in the JSON response.

  private

  def product_params
    params.require(:product).permit(:name, :description, :inventory, :price)
  end
end
