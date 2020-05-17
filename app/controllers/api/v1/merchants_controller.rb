class Api::V1::MerchantsController < ApplicationController
  def index
    records = Merchant.all
    render json: serialize_merchant(records)
  end

  private

  def serialize_merchant(records)
    MerchantSerializer.new(records).serialized_json
  end
end
