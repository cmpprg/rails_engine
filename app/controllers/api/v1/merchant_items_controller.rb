class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant_items = Merchant.find(params[:merchant_id]).items
    render json: serialize_item(merchant_items)
  end

  private

  def serialize_item(items)
    ItemSerializer.new(items)
  end
end
