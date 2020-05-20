class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: serialize_merchant(search_merchant.first)
  end

  def index
    render json: serialize_merchant(search_merchant)
  end

  private

  def serialize_merchant(record)
    MerchantSerializer.new(record).serialized_json
  end

  def search_merchant
    merchant = Merchant.where(nil)
    merchant = merchant.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
    merchant = merchant.where('DATE(created_at) = ?', Date.parse(params[:created_at])) if params[:created_at].present?
    merchant = merchant.where('DATE(updated_at) = ?', Date.parse(params[:updated_at])) if params[:updated_at].present?
    merchant
  end
end
