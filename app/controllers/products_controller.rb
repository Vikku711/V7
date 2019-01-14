class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      puts e
      logger.error("Message for the log file #{e.message}")
      flash[:notice] = "Store error message"
      redirect_to(:action => 'index')
    end
  end

  def new
    @product = Product.new
  end

  def create
    p "here am inserting"
    begin
      @product = Product.new(product_params)
      if @product.save
        flash[:notice] = 'Product added!'
        redirect_to root_path
      else
        flash[:error] = 'Failed to edit product!'
        render :new
      end
    rescue ActiveRecord::RecordNotFound => e
      print e
      logger.error("Message for the log file #{e.message}")
      flash[:notice] = "Store error message"
      redirect_to(:action => 'index')
    end

  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:notice] = 'Product updated!'
      redirect_to root_path
    else
      flash[:error] = 'Failed to edit product!'
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.delete
      flash[:notice] = 'Product deleted!'
      redirect_to root_path
    else
      flash[:error] = 'Failed to delete this product!'
      render :destroy
    end
  end

  def product_params
    params.require(:product).permit(:name, :price, :old_price, :short_description, :full_description)
  end

end
