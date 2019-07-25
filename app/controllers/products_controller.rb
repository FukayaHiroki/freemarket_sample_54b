class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update]

  def index
    @category = Category.all
    @products = Product.include.limited(4)
    @category_men   = Product.include.category(340..470).limited(4)
    @category_women = Product.include.category(160..339).limited(4)
    @category_baby  = Product.include.category(471..586).limited(4)
    @category_cosme = Product.include.category(867..954).limited(4)
  end

  def show
    @category = Category.all
    @product  = Product.find(params[:id])
    @images   = @product.images
    @comments = @product.comments.includes(:user)
    @comment  = Comment.new
    @seller_products   = Product.where(user_id:     @product.user_id)    .limit(6).order("created_at DESC")
    @category_products = Product.where(category_id: @product.category_id).limit(6).order("created_at DESC")
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
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id) 
    end
  end

  def pay
    @product = Product.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
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
    @product = Product.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id) 
    end
  end

  def new
    @product = Product.new
    @product.images.build
    @product.build_trading
    @category = Category.all

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

  
end
