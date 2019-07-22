class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update]

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
    redirect_to buy_done_product_path
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

    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @product = Product.create(product_params)
    
    if @product.save
        # new_image_params[:images].each do |image|
        #   @product.images.create(url: image)
        # end
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @product.images.build
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # カテゴリーjsのアクション
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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
      :category_id,
      images_attributes: [:url, :product_id], 
      trading_attributes: [:status, :user_id],
    ).merge(user_id: current_user.id)
  end

  # def new_image_params
  #   params.require(:new_images).permit({photos: []})
  # end

  def set_product
    @product = Product.find(params[:id])
  end

  
end
