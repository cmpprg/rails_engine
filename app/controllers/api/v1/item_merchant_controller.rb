class Api::V1::ItemMerchantController < ApplicationController
  def show
    merchant = Item.find(params[:item_id]).merchant
    render json: serialize_merchant(merchant)
  end

  private

  def serialize_merchant(merchant)
    MerchantSerializer.new(merchant)
  end
end
