class Api::V1::MerchantsController < ApplicationController
  def index
    records = Merchant.all
    render json: serialize_merchant(records)
  end

  def show
    record = Merchant.find(params[:id])
    render json: serialize_merchant(record)
  end

  def create
    new_merchant = Merchant.create(merchant_params)
    render json: serialize_merchant(new_merchant)
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def serialize_merchant(records)
    MerchantSerializer.new(records).serialized_json
  end
end
