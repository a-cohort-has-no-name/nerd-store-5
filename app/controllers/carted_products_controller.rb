class CartedProductsController < ApplicationController

  def create
    CartedProduct.create(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted")
    redirect_to '/carted_products'
  end

  def index
    #show carted products that belong to current_user and have status of carted
    # @carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    if current_user && current_user.carted_products.where(status: "carted").any?
      @carted_products = current_user.carted_products.where(status: "carted") 
      render :index
    else
      flash[:warning] = "You have no items in your shopping cart. Womp womp."
      redirect_to "/"
    end
  end

  def destroy
    carted_product = CartedProduct.find(params[:id])
    carted_product.update(status: "removed")
    flash[:success] = "Product removed"
    redirect_to "/carted_products"
  end

end
