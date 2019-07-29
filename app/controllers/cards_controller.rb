class CardsController < ApplicationController

  require "payjp"

  def index
    @category = Category.all
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      card = Card.find_by(user_id: current_user.id)
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id) 
    end
  end

  def new
    card = Card.where(user_id: current_user.id).first
    @category = Category.all
    if card.blank?
    else
      redirect_to user_cards_path(current_user)
    end
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
    customer = Payjp::Customer.create
    card = customer.cards.create(card: params[:payjp_token])
    @card = Card.create(user_id: current_user.id, customer_id: customer.id, card_id: card.id)
    redirect_to user_cards_path(current_user)
  end

  def delete
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials.payjp[:payjp_api_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to new_user_card_path(current_user)
  end
end
