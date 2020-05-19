class Api::V1::Merchants::SearchController < ApplicationController
  def show
    @merchant = Merchant.all
    @merchant = @merchant.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
    @merchant = @merchant.where(created_at: DateTime.parse(params[:created_at])) if params[:created_at].present?
    render json: serialize_merchant(@merchant.first)
  end

  private

  def serialize_merchant(record)
    MerchantSerializer.new(record).serialized_json
  end

  # User.where("Date(updated_at) = ?", "2018-02-9") potential solution for created@ updated@

end
