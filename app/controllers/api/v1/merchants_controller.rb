class Api::V1::MerchantsController < ApplicationController
  def index
    records = Merchant.all
    render json: serialize_merchant(records)
  end

  def show
    record = Merchant.find(params[:id])
    render json: serialize_merchant(record)
  end

  private

  def serialize_merchant(records)
    MerchantSerializer.new(records).serialized_json
  end
end
