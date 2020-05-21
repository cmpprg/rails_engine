class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    # put this in the model vvvvv
    merchants = Merchant.joins(:transactions).
    where(transactions: { result: 'success' }).
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price)
            as total_revenue').
    group(:id).
    order(total_revenue: :desc).
    limit(params[:quantity])
    # put this in the model ^^^^^
    render json: MerchantSerializer.new(merchants)
  end
end
