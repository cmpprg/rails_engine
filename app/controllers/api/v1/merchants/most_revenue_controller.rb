class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    # put this in the model vvvvv
    merchants = Merchant.joins(:transactions).
    group(:id).
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price)
            as total_revenue').
    where(transactions: { result: 'success' }).
    order(total_revenue: :desc).
    limit(params[:quantity])
    # put this in the model ^^^^^
    render json: MerchantSerializer.new(merchants)
  end
end
