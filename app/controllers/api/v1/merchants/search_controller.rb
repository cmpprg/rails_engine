class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%").first if params[:name].present?
    require 'pry'; binding.pry
    render json: serialize_merchant(merchant)
  end

  private

  def serialize_merchant(record)
    MerchantSerializer.new(record).serialized_json
  end

  # User.where("Date(updated_at) = ?", "2018-02-9") potential solution for created@ updated@

end
