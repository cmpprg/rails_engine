class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: serialize_item(items)
  end

  def show
    item = Item.find(params[:id])
    render json: serialize_item(item)
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    new_item = merchant.items.create(item_params)
    render json: serialize_item(new_item)
  end

  def update
    edited_item = Item.update(params[:id], item_params)
    render json: serialize_item(edited_item)
  end

  def destroy
    deleted_item = Item.destroy(params[:id])
    render json: serialize_item(deleted_item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end

  def serialize_item(records)
    ItemSerializer.new(records).serialized_json
  end

end
