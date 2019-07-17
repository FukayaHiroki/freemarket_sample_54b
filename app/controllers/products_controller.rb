class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find_by(id: 1)
  end
  
  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    redirect_to("/")
  end

  require 'payjp'

  def buy
    @product = Product.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id) 
    end
  end

  def pay
    @product = Product.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
      amount:   @product.price,
      customer: card.customer_id,
      currency: 'jpy'
      )
    end
    # product_pathを使うとshowアクションになってしまうため、URLで指定
    redirect_to "/products/#{@product.id}/buy/done"
  end

  def done
    @product = Product.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id) 
    end
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
