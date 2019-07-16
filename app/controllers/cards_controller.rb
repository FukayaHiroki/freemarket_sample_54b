class CardsController < ApplicationController
  protect_from_forgery except: :pay
  require "payjp"
    # respond_to do |format|
    #   format.html { redirect_to group_messages_path(@group)}
    #   format.json
    # end
end