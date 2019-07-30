class ProductsController < ApplicationController
  before_action :set_product,  only: [:show, :edit, :update, :buy, :done, :pay]
  before_action :set_category, only: [:index, :new, :show]

  def index
    @products = Product.include.limited(4)
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
      image_params[:url].each do |image|
        @product.images.create(url: image)
      end
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @product.images.build
    @category               = @product.category
    @category_parent        = @category.parent.parent.siblings
    @category_children      = @category.parent.siblings
    @category_grandchildren = @category.siblings
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @seller_products   = Product.where(user_id:     @product.user_id)    .limited(6)
    @category_products = Product.where(category_id: @product.category_id).limited(6)
    @comment           = Comment.new
  end
  
  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    redirect_to("/")
  end

  require 'payjp'

  def buy
    card = Card.find_by(user_id: current_user.id)
    unless card.blank?
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id) 
    end
  end

  def pay
    card = Card.where(user_id: current_user.id).first
    unless card.blank?
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
      Payjp::Charge.create(
      amount:   @product.price,
      customer: card.customer_id,
      currency: 'jpy'
      )
    end
    redirect_to buy_done_product_path
  end

  def done
    card = Card.find_by(user_id: current_user.id)
    unless card.blank?
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id) 
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
      :size_id,
      :brand,
   
      trading_attributes: [:status, :user_id],
    ).merge(user_id: current_user.id)
  end

  def image_params
    params.require(:images).permit({url: []})
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @category = Category.all
  end  
end
