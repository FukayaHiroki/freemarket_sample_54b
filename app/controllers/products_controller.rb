class ProductsController < ApplicationController
  def index
  end

  def show
  end

  def buypage
  end

  def new
    @product = Product.new
    @product.images.build
    @product.build_trading
    @product.build_large_category
  end

  def create
    @product = Product.create!(product_params)
    if @product.save
      # params[:images]['url'].each do |a|
      #   @images = @product.images.create!(url: a)
      # end
      redirect_to root_path
    else
      render :new
    end
  end
  
  private
  def product_params
    params.require(:product).permit(
      :name, 
      :detail,
      :price, 
      :prefecture_id, 
      :condition_id,
      :delivery_fee_id,
      :shipping_speed_id,
      :shipping_method_id,
      images_attributes: [:url, :product_id], 
      trading_attributes: [:status, :user_id],
      large_category_attributes: [:name],
    ).merge(user_id: 1)
  end
end
