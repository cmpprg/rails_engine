class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: serialize_merchant(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: serialize_merchant(merchant)
  end

  def create
    new_merchant = Merchant.create(merchant_params)
    render json: serialize_merchant(new_merchant)
  end

  def update
    edited_merchant = Merchant.update(params[:id], merchant_params)
    render json: serialize_merchant(edited_merchant)
  end

  def destroy
    deleted_merchant = Merchant.destroy(params[:id])
    render json: serialize_merchant(deleted_merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def serialize_merchant(records)
    MerchantSerializer.new(records).serialized_json
  end
end
