class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    #should be in model vvvvv
    merchants = Merchant.joins(:transactions).
    where(transactions: { result: 'success' }).
    select('merchants.*, sum(invoice_items.quantity) as total_quantity').
    group(:id).
    order(total_quantity: :desc).
    limit(params[:quantity])
    #should be in model ^^^^^
    render json: MerchantSerializer.new(merchants)
  end
end
