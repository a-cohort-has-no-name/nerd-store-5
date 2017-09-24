class ProductsController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show, :search]

  def index
    if session[:count] == nil
      session[:count] = 0
    end
    session[:count] += 1
    @visit_count = session[:count]
    @products = Product.all
    if params[:sort] && params[:sort_order]
      @products = Product.all.order(params[:sort] => params[:sort_order])
    end
    if params[:discount]
      @products = Product.where("price <= ?", "2")
    end
    if params[:category]
      selected_category = Category.find_by(title: params[:category])
      @products = selected_category.products
    end
    render "index.html.erb"
  end

  def new
    @product = Product.new
    render "new.html.erb"
  end

  def create
    supplier_id = params[:supplier]['supplier_id']
    @product = Product.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      supplier_id: supplier_id
    )
    if @product.save
      flash[:success] = "Product Created"
      redirect_to "/products/#{@product.id}"
    else
      render :new
    end
  end

  def show
    if params[:id] == "random"
      products = Product.all
      @product = products.sample
    else
      @product = Product.find_by(id: params[:id])
    end
    render "show.html.erb"
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update(
      name: params[:name],
      description: params[:description],
      image: params[:image],
      price: params[:price]
    )
    flash[:success] = "Product Updated"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    flash[:warning] = "Product Destroyed"
    redirect_to "/"
  end

  def search
    search_term = params[:search]
    @products = Product.where("name LIKE ?", "%#{search_term}%")
    render "index.html.erb"
  end
end




















